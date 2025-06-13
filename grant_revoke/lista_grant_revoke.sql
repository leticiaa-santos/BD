/* EXERCICIO 1:  Crie um usuário chamado relatorio_user com senha 1234rel que possa apenas 
fazer consultas (SELECT) em todas as tabelas do banco VendasEmpresa. */

CREATE USER 'relatorio_user'@'localhost'
IDENTIFIED BY '1234rel';

GRANT SELECT ON biblioteca_joins.* TO 'relatorio_user'@'localhost';

/* EXERCICIO 2:  Crie um usuário editor_produto com acesso apenas para leitura e atualização 
(SELECT, UPDATE) na tabela Produto do banco LojaOnline.*/

CREATE USER 'editor_produto'@'localhost'
IDENTIFIED BY '1234edi';

GRANT SELECT, UPDATE ON biblioteca_joins.livros TO 'editor_produto'@'localhost';

/*EXERCICIO 3: Dê permissão ao usuário gestorRH para inserir e consultar dados da tabela 
Funcionario, mas não para alterar nem excluir*/

CREATE USER 'gestorRH'@'localhost'
IDENTIFIED BY '1234gestor';

GRANT INSERT, SELECT ON biblioteca_joins.editoras TO 'gestorRH'@'localhost';

/*EXERCICIO 4: Crie um usuário dev_backup que tenha permissão total para todos os bancos do 
servidor, inclusive criar e excluir bancos.*/

CREATE USER 'dev_backup'@'localhost'
IDENTIFIED BY '1234dev';

GRANT ALL PRIVILEGES ON *.* TO 'dev_backup'@'localhost';

/*EXERCICIO 5:  Remova do usuário editor_produto a permissão de UPDATE, mantendo apenas a 
leitura.*/

REVOKE UPDATE ON biblioteca_joins.livros FROM 'editor_produto'@'localhost';

/*EXERCICIO 6: Exclua o usuário relatorio_user.*/

DROP USER 'relatorio_user'@'localhost';

/*EXERCICIO 7: Mostre os comandos necessários para verificar as permissões atuais do usuário 
gestorRH.*/

SHOW GRANTS FOR 'gestorRH'@'localhost';

/*EXERCICIO 8: Crie um usuário analista_fiscal que pode fazer consultas na tabela NotasFiscais 
do banco Financeiro, mas só quando estiver acessando da máquina local.*/

CREATE USER 'analista_fiscal'@'localhost'
IDENTIFIED BY '1234anali';

GRANT SELECT ON biblioteca_joins.emprestimos TO 'analista_fiscal'@'localhost';

/*EXERCICIO 9: . Crie um usuário mobile_app com acesso total apenas à tabela Pedidos do banco 
DeliveryApp. Use o coringa % para permitir acesso remoto.*/

CREATE USER 'mobile_app'@'%'
IDENTIFIED BY '1234mobile';

GRANT ALL PRIVILEGES ON biblioteca_joins.leitores TO 'mobile_app'@'%';

/*EXERCICIO 10:  O usuário suporteTI está com acesso total ao banco RHInterno. Remova todos 
os privilégios dele*/

REVOKE ALL PRIVILEGES ON *.* FROM 'dev_backup'@'localhost';