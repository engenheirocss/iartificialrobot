/*
MySQL Data Transfer
Source Host: localhost
Source Database: boletocliente
Target Host: localhost
Target Database: boletocliente
Date: 12/01/2015 17:52:54
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for bancos
-- ----------------------------
CREATE TABLE `bancos` (
  `id_banco` int(30) NOT NULL AUTO_INCREMENT,
  `nome_banco` varchar(200) NOT NULL,
  `carteira` varchar(4) NOT NULL,
  `agencia` int(30) NOT NULL,
  `digito_ag` int(5) NOT NULL,
  `conta` int(10) NOT NULL,
  `digito_co` int(5) NOT NULL,
  `nosso_numero` int(20) NOT NULL,
  `tipo_cobranca` varchar(20) NOT NULL,
  `convenio` varchar(30) NOT NULL,
  `contrato` varchar(30) NOT NULL,
  `tipo_carteira` varchar(5) NOT NULL,
  `situacao` int(1) NOT NULL,
  `img` varchar(50) NOT NULL,
  `img2` varchar(200) NOT NULL,
  `link` varchar(60) NOT NULL,
  PRIMARY KEY (`id_banco`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
CREATE TABLE `cliente` (
  `id_cliente` int(30) NOT NULL AUTO_INCREMENT,
  `id_grupo` int(30) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `cpfcnpj` varchar(18) NOT NULL,
  `rg` varchar(20) NOT NULL,
  `inscricao` varchar(50) NOT NULL,
  `endereco` varchar(200) NOT NULL,
  `numero` int(10) NOT NULL,
  `complemento` varchar(200) NOT NULL,
  `bairro` varchar(200) NOT NULL,
  `cidade` varchar(200) NOT NULL,
  `uf` varchar(20) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `cep` varchar(15) NOT NULL,
  `email` varchar(250) NOT NULL,
  `obs` text NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `bloqueado` varchar(1) NOT NULL,
  `senha` varchar(10) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for config
-- ----------------------------
CREATE TABLE `config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `cpf` varchar(50) NOT NULL,
  `endereco` varchar(250) NOT NULL,
  `cidade` varchar(200) NOT NULL,
  `uf` varchar(2) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `receber` varchar(3) NOT NULL,
  `dias` varchar(2) NOT NULL,
  `multa_atrazo` varchar(10) NOT NULL,
  `juro` varchar(50) NOT NULL,
  `demo1` varchar(200) NOT NULL,
  `demo2` varchar(200) NOT NULL,
  `demo3` varchar(200) NOT NULL,
  `demo4` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for faturas
-- ----------------------------
CREATE TABLE `faturas` (
  `id_venda` bigint(60) NOT NULL AUTO_INCREMENT,
  `nosso_numero` bigint(60) NOT NULL,
  `modulo` varchar(50) NOT NULL,
  `codbanco` varchar(10) NOT NULL,
  `dbaixa` date NOT NULL,
  `banco_receb` varchar(20) NOT NULL,
  `dv_receb` int(2) NOT NULL,
  `banco` varchar(30) NOT NULL,
  `id_cliente` int(30) NOT NULL,
  `nome` varchar(200) NOT NULL,
  `ref` varchar(250) NOT NULL,
  `data` date NOT NULL,
  `data_venci` date NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `valor_recebido` decimal(10,2) NOT NULL,
  `situacao` varchar(1) NOT NULL,
  `num_doc` varchar(30) NOT NULL,
  `condmail` int(1) NOT NULL,
  `emailcli` varchar(100) NOT NULL,
  `tipofatura` varchar(20) NOT NULL,
  PRIMARY KEY (`id_venda`),
  UNIQUE KEY `id_venda` (`id_venda`),
  UNIQUE KEY `num_doc` (`num_doc`),
  KEY `id_venda_2` (`id_venda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for financeiro
-- ----------------------------
CREATE TABLE `financeiro` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `banco` varchar(50) NOT NULL,
  `ag_receb` varchar(200) NOT NULL,
  `dv_receb` varchar(200) NOT NULL,
  `nosso_numero` bigint(30) NOT NULL,
  `vencimento` varchar(50) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nosso_numero_2` (`nosso_numero`),
  KEY `nosso_numero` (`nosso_numero`),
  KEY `id` (`id`),
  KEY `id_2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for flux_entrada
-- ----------------------------
CREATE TABLE `flux_entrada` (
  `id_entrada` int(50) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(2) CHARACTER SET utf8 NOT NULL,
  `data` date NOT NULL,
  `id_plano` int(50) NOT NULL,
  `descricao` varchar(200) CHARACTER SET utf8 NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_entrada`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for flux_fixas
-- ----------------------------
CREATE TABLE `flux_fixas` (
  `id_fixa` int(20) NOT NULL AUTO_INCREMENT,
  `descricao_fixa` varchar(200) NOT NULL,
  `dia_vencimento` varchar(2) NOT NULL,
  `valor_fixa` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_fixa`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for flux_planos
-- ----------------------------
CREATE TABLE `flux_planos` (
  `id_plano` int(50) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) NOT NULL,
  PRIMARY KEY (`id_plano`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for grupo
-- ----------------------------
CREATE TABLE `grupo` (
  `id_grupo` int(10) NOT NULL AUTO_INCREMENT,
  `nomegrupo` varchar(200) NOT NULL,
  `meses` int(3) NOT NULL,
  `dia` int(2) NOT NULL,
  `valor` varchar(20) NOT NULL,
  PRIMARY KEY (`id_grupo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for maile
-- ----------------------------
CREATE TABLE `maile` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `empresa` varchar(250) NOT NULL,
  `url` varchar(250) NOT NULL,
  `porta` varchar(20) NOT NULL,
  `endereco` varchar(250) NOT NULL,
  `limitemail` varchar(30) NOT NULL,
  `aviso` varchar(250) NOT NULL,
  `avisofataberto` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `senha` varchar(30) NOT NULL,
  `text1` longtext NOT NULL,
  `text2` longtext NOT NULL,
  `text3` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for pag_extra
-- ----------------------------
CREATE TABLE `pag_extra` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user` varchar(100) DEFAULT NULL,
  `pass` varchar(200) DEFAULT NULL,
  `assinatura` varchar(200) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `ativo` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
CREATE TABLE `usuario` (
  `id_usuario` int(10) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `login` varchar(20) NOT NULL,
  `senha` varchar(10) NOT NULL,
  `hash` varchar(250) NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `bancos` VALUES ('1', 'BANCO DO BRASIL', '19', '3307', '3', '105162', '8', '0', '2', '2535632', '', '', '0', 'bb.png', 'bb2.png', 'boleto_bb.php');
INSERT INTO `bancos` VALUES ('2', 'BRADESCO', '09', '2344', '2', '19423', '9', '0', '', '', '', '', '0', 'bradesco.png', 'bradesco2.png', 'boleto_bradesco.php');
INSERT INTO `bancos` VALUES ('3', 'CAIXA ECONOMICA', '02', '4068', '0', '242997', '0', '0', '', '242997', '', 'CR', '1', 'caixa.png', 'caixa2.png', 'boleto_cef_sigcb.php');
INSERT INTO `bancos` VALUES ('4', 'ITAU', '178', '6633', '0', '19236', '1', '0', '', '', '', '', '0', 'itau.png', 'itau2.png', 'boleto_itau.php');
INSERT INTO `cliente` VALUES ('1', '5', 'ELSON', '000.000.000-00', '', '', '', '0', '', '', '', '', '', '', 'elsoneal@gmail.com', '', '20.00', 'N', '123');
INSERT INTO `config` VALUES ('1', 'Griff Sistemass', 'griffsistemas@gmail.com', '02.326.555/0001-23', 'Rua PA-2', 'Anicuns', 'GO', '1ab581a8f991acd.png', '10', '30', '2', '0.5', 'dados de instrucoes 1', 'dados de instrucoes 2', 'dados de instrucoes 3', 'dados de instrucoes 4');
INSERT INTO `grupo` VALUES ('1', 'AVULSO', '0', '0', '');
INSERT INTO `grupo` VALUES ('5', 'teste', '1', '10', '');
INSERT INTO `maile` VALUES ('1', 'Griff sistemas', 'smtp.barreirao.co', '25', 'http://localhost/GrBoletoCliente2.0.3fluxo/', '250', 'Aviso de Fatura gerada', 'Reaviso de cobrança', 'elson@barreirao.com', 'web102030', '<h2>Griff Sistemas</h2>\r\n<hr />\r\n<p><strong>Ol&aacute; [NomedoCliente],</strong></p>\r\n<p><strong>Voc&ecirc; tem uma nova fatura.<br /></strong></p>\r\n<ul>\r\n<li><strong>Valor:</strong> [valor]</li>\r\n<li><strong>Vencimento:</strong> [vencimento]</li>\r\n<li><strong>N&ordm; da Fatura: </strong>[numeroFatura]</li>\r\n</ul>\r\n<p><strong>Refer&ecirc;nte a:</strong> [Descricaodafatura]</p>\r\n<p><strong>Para efetuar o pagamento, clique no bot&atilde;o abaixo \"Realizar Pagamento\"</strong></p>\r\n<p>[link]</p>\r\n<p>ou acesse o portal do clientessdfasd</p>\r\n<p>www.portal.com/pasta/clietne</p>\r\n<p>- Central de atendimento no e-mail: <strong>suporte@griffsistemas.com.br</strong><br /> - 2&ordm; Via do Boleto, solicite no e-mail: <strong>financeiro@griffsistemas.com.br</strong></p>\r\n<hr />\r\n<p><strong>AVISO LEGAL</strong>: Esta mensagem &eacute; destinada exclusivamente para a(s) pessoa(s) a quem &eacute; dirigida, podendo conter informa&ccedil;&atilde;o confidencial e/ou legalmente privilegiada. Se voc&ecirc; n&atilde;o for destinat&aacute;rio desta mensagem, desde j&aacute; fica notificado de abster-se a divulgar, copiar, distribuir, examinar ou, de qualquer forma, utilizar a informa&ccedil;&atilde;o contida nesta mensagem, por ser ilegal. Caso voc&ecirc; tenha recebido esta mensagem por engano, pedimos que nos retorne este E-Mail, promovendo, desde logo, a elimina&ccedil;&atilde;o do seu conte&uacute;do em sua base de dados, registros ou sistema de controle. Fica desprovida de efic&aacute;cia e validade a mensagem que contiver v&iacute;nculos obrigacionais, expedida por quem n&atilde;o detenha poderes de representa&ccedil;&atilde;o.</p>', '<h2>Griff Sistemas</h2>\r\n<hr />\r\n<p><strong>Ol&aacute; [NomedoCliente],</strong></p>\r\n<p><strong>Ainda n&atilde;o identificamos o pagamento da fatura descrita a baixo:</strong></p>\r\n<ul>\r\n<li><strong>Valor:</strong> [valor]</li>\r\n<li><strong>Vencimento:</strong> [vencimento]</li>\r\n<li><strong>N&ordm; da Fatura: </strong>[numeroFatura]</li>\r\n</ul>\r\n<p><strong>Refer&ecirc;nte a:</strong> [Descricaodafatura]</p>\r\n<p><strong>Para efetuar o pagamento, clique no bot&atilde;o abaixo \"Realizar Pagamento\"</strong></p>\r\n<p>[link]</p>\r\n<p>- Central de atendimento no e-mail: <strong>suporte@griffsistemas.com.br</strong><br /> - 2&ordm; Via do Boleto, solicite no e-mail: <strong>financeiro@griffsistemas.com.br</strong></p>\r\n<hr />\r\n<p><strong>AVISO LEGAL</strong>: Esta mensagem &eacute; destinada exclusivamente para a(s) pessoa(s) a quem &eacute; dirigida, podendo conter informa&ccedil;&atilde;o confidencial e/ou legalmente privilegiada. Se voc&ecirc; n&atilde;o for destinat&aacute;rio desta mensagem, desde j&aacute; fica notificado de abster-se a divulgar, copiar, distribuir, examinar ou, de qualquer forma, utilizar a informa&ccedil;&atilde;o contida nesta mensagem, por ser ilegal. Caso voc&ecirc; tenha recebido esta mensagem por engano, pedimos que nos retorne este E-Mail, promovendo, desde logo, a elimina&ccedil;&atilde;o do seu conte&uacute;do em sua base de dados, registros ou sistema de controle. Fica desprovida de efic&aacute;cia e validade a mensagem que contiver v&iacute;nculos obrigacionais, expedida por quem n&atilde;o detenha poderes de representa&ccedil;&atilde;o.</p>', '<p>Seu cadastro foi efetuado com sucesso em nosso sistema.</p>\r\n\r\n<p>Segue seus dados de acesso: testesasdf</p>\r\n');
INSERT INTO `pag_extra` VALUES ('1', 'elsoneal_api1.gmail.com', '932QL8EPEZK3BSDL', 'An5ns1Kso7MWUdW4ErQKJJJ4qi4-Aze.bSGE.ELVBCX3IEMrd3PIKf.Q', 'http://www.barreirao.com/logos/logopay.png', 'nao');
INSERT INTO `usuario` VALUES ('1', 'Administrador', 'admin', 'admin', 'c7ad44cbad762a5da0a452f9e854fdc1e0e7a52a38015f23f3eab1d80b931dd472634dfac71cd34ebc35d16ab7fb8a90c81f975113d6c7538dc69dd8de9077ec');
