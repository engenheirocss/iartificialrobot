<?php
include "../classes/conexao.php";
////////////// arredonda valores /////////////////////////////////
function ceil_dec($number,$precision,$separator)
{
    $numberpart=explode($separator,$number); 
	@$numberpart[1]=substr_replace($numberpart[1],$separator,$precision,0);
    if($numberpart[0]>=0)
    {$numberpart[1]=ceil($numberpart[1]);}
    else
    {$numberpart[1]=floor($numberpart[1]);}

    $ceil_number= array($numberpart[0],$numberpart[1]);
    return implode($separator,$ceil_number);
}
/////////////////////// conferir datas //////////////
function data2banco ($d2b) { 
	if(!empty($d2b)){
		$d2b_ano=substr($d2b,6,4);
		$d2b_mes=substr($d2b,3,2);
		$d2b_dia=substr($d2b,0,2);		
		$d2b="$d2b_ano-$d2b_mes-$d2b_dia";
	}
	return $d2b; 
}
//------------------------------------------------------------------------
$sql = mysql_query("SELECT * FROM config")or die (mysql_error());
$linha = mysql_fetch_array($sql);

$logo = $linha['logo'];

$banco = mysql_query("SELECT * FROM bancos WHERE id_banco='4'")or die (mysql_error());
$li = mysql_fetch_array($banco);

$str = $_SERVER['QUERY_STRING'];
$string = base64_decode($str);
$array = explode('&', $string);
foreach($array as $valores){
	$valores;
	$arrays = explode('=', $valores);
		foreach($arrays as $val){
		$dado[] = $val;
		}
}
if(!isset($_GET['id_venda'])){
	$id_venda = $arrays[1];	
}else{
$id_venda = $_GET['id_venda'];
}


////////////////////////////////////////////////////////////////////////////////

$compra = mysql_query("SELECT *,date_format(data_venci, '%d/%m/%Y') AS datad, date_format(data, '%d/%m/%Y') AS data FROM faturas WHERE id_venda='$id_venda' AND situacao !='B'")or die (mysql_error());
$valor = mysql_fetch_array($compra);
$contar = mysql_num_rows($compra);
$valor_doc = $valor['valor'];
$idcliente = $valor['id_cliente'];
$dat_novo_venc = date("d/m/Y");
$juros = $linha['juro'];
$multa = $linha['multa_atrazo'];

if($contar != 1){
	echo "<META HTTP-EQUIV=REFRESH CONTENT='0; URL=erro.php'>";
	exit;	
}


////////////////////////// CALCULA DIAS DE VENCIDO /////////////////////
$data_inicial = $valor['datad'];;
$data_final = date("d/m/Y");

function geraTimestamp($data) {
$partes = explode('/', $data);
return mktime(0, 0, 0, $partes[1], $partes[0], $partes[2]);
}
$time_inicial = geraTimestamp($data_inicial);
$time_final = geraTimestamp($data_final);
$diferenca = $time_final - $time_inicial; 
$dias = (int)floor( $diferenca / (60 * 60 * 24));
//------------- SE O VALOR FOR NEGATIVO COLOCA ZERO NA DIVERENCA ------------------------
if($dias <= 0){
	$dias = 0;		
}

////////////////////////////////////CALCULA JUROS //////////////////////////////////////////
$jurost = ($juros * $dias);

$valordojuro = ($valor_doc * $jurost / 100); 
$valorcomjuros = ($valor_doc + $valordojuro);
if($dias <= 0){
	$multa = 0;		
}
$valormulta = ($valorcomjuros * $multa / 100 );

$valor_boleto = @ceil_dec($valorcomjuros + $valormulta,2,'.');


// DADOS DO BOLETO PARA O SEU CLIENTE
$dias_de_prazo_para_pagamento = $linha['receber'];
$vencimento = data2banco($valor['datad']);
$data_atual = date("Y-m-d");
if($vencimento < $data_atual){
$data_venc = date("d/m/Y");
}else{
$data_venc = $valor['datad'];
}
$valor_cobrado = $valor_boleto; // Valor - REGRA: Sem pontos na milhar e tanto faz com "." ou "," ou com 1 ou 2 ou sem casa decimal
$valor_cobrado = str_replace(",", ".",$valor_cobrado);
$valor_boleto = number_format($valor_cobrado, 2, ',', '');

$dadosboleto["nosso_numero"] = $id_venda;  // Nosso numero - REGRA: M??ximo de 8 caracteres!
$dadosboleto["numero_documento"] = $dadosboleto["nosso_numero"];	// Num do pedido ou nosso numero
$dadosboleto["data_vencimento"] = $data_venc; // Data de Vencimento do Boleto - REGRA: Formato DD/MM/AAAA
$dadosboleto["data_documento"] = $valor['data']; // Data de emiss??o do Boleto
$dadosboleto["data_processamento"] = date("d/m/Y"); // Data de processamento do boleto (opcional)
$dadosboleto["valor_boleto"] = $valor_boleto; 	// Valor do Boleto - REGRA: Com v??rgula e sempre com duas casas depois da virgula

// DADOS DO SEU CLIENTE
$cli = mysql_query("SELECT * FROM cliente WHERE id_cliente='$idcliente'")or die (mysql_error());
$cliente = mysql_fetch_array($cli);
$Cnome = $cliente['nome'];
$rg = $cliente['rg'];
$endereco = $cliente['endereco'];
$numero = $cliente['numero'];
$bairro = $cliente['bairro'];
$cidade = $cliente['cidade'];
$estado = $cliente['uf'];
$cep = $cliente['cep'];
$cpfcnpj = $cliente['cpfcnpj'];


$dadosboleto["sacado"] = "$Cnome - $cpfcnpj";
$dadosboleto["endereco1"] = "$endereco, N?? $numero - $bairro";
$dadosboleto["endereco2"] = "$cidade - $estado - CEP: $cep";

// INFORMACOES PARA O CLIENTE
$dadosboleto["demonstrativo1"] = $valor['ref'];
$dadosboleto["demonstrativo2"] = $linha['demo1'];
$dadosboleto["demonstrativo3"] = $linha['demo2'];
$dadosboleto["instrucoes1"] = $linha['demo1'];
$dadosboleto["instrucoes2"] = $linha['demo2'];
$dadosboleto["instrucoes3"] = $linha['demo3'];
$dadosboleto["instrucoes4"] = $linha['demo4'];

// DADOS OPCIONAIS DE ACORDO COM O BANCO OU CLIENTE
$dadosboleto["quantidade"] = "001";
$dadosboleto["valor_unitario"] = $valor_boleto;
$dadosboleto["aceite"] = "SEM";		
$dadosboleto["uso_banco"] = ""; 	
$dadosboleto["especie"] = "R$";
$dadosboleto["especie_doc"] = "DM";


// ---------------------- DADOS FIXOS DE CONFIGURA????O DO SEU BOLETO --------------- //


// DADOS DA SUA CONTA - ITA??
$dadosboleto["agencia"] = $li['agencia']; // Num da agencia, sem digito
$dadosboleto["conta"] = $li['conta']; 	// Num da conta, sem digito
$dadosboleto["conta_dv"] = $li['digito_co']; 	// Digito do Num da conta

// DADOS PERSONALIZADOS - ITA??
$dadosboleto["carteira"] = $li['carteira'];  // C??digo da Carteira

// SEUS DADOS
$dadosboleto["identificacao"] = $linha['nome'];
$dadosboleto["cpf_cnpj"] = $linha['cpf'];
$dadosboleto["endereco"] = $linha['endereco'];
$dadosboleto["cidade_uf"] = $linha['cidade'].' - '. $linha['uf'];
$dadosboleto["cedente"] = $linha['nome'].'.';
$dadosboleto["cpf_cnpj"] = $linha['cpf'];

// N??O ALTERAR!
include("include/funcoes_itau.php"); 
include("include/layout_itau.php");
$numero = explode("/",$dadosboleto["nosso_numero"]);
$d = explode("-",$numero[1]);
$res = $d[0];
$banco = "ITAU";
$up = mysql_query("UPDATE faturas SET nosso_numero ='$res', banco ='$banco' WHERE id_venda='$id_venda'") or die(mysql_error());
?>
