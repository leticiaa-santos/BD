USE sistema_biblioteca;

SELECT * FROM livros;

SELECT * FROM categoria;

SELECT * FROM autores;

SELECT * FROM usuario;

SELECT * FROM livro_categoria;

SELECT * FROM livro_autor;

SELECT * FROM emprestimos;

SELECT * FROM associacao;

SELECT 
	livros.titulo,
    autores.nome_autor
FROM livros
INNER JOIN livro_autor ON livros.id_livro = livro_autor.id_livro
INNER JOIN autores ON autores.id_autor = livro_autor.id_autor;

SELECT
	livros.titulo,
    usuario.nome_usuario
FROM livros
INNER JOIN emprestimos ON livros.id_livro = emprestimos.id_livro
INNER JOIN usuario ON usuario.id_usuario = emprestimos.id_usuario;

SELECT
	usuario.nome_usuario,
    associacao.nivel
FROM usuario
INNER JOIN associacao ON usuario.id_usuario = associacao.id_usuario;



    

