/****************************************
	
	NOT NULL
		Campo não pode ser nulo

	NULL
		Campo pode ser nulo

	IDENTITY(inicio, incremento)
		Gera valores inteiros que são auto-incrementais   

	DBCC Checkident( nome_tabela, reseed, 0)
		Reseta o auto-increment

	exec sp_help nome_tabela
		É uma procedure para exibir o detalhe de uma tabela

******************************************/

/* Criar o banco */
CREATE DATABASE estudos
GO

/* Conectando-se no banco */
USE estudos 
GO

/* Criando as tabelas */

/* alunos */
CREATE TABLE alunos (
	id INT NOT NULL IDENTITY(1, 1),
	nome VARCHAR(200) NOT NULL,
	sexo CHAR(1) NOT NULL,
	data_cadastro DATETIME NOT NULL,
	login_cadastro VARCHAR(15) NOT NULL
)
GO

/* situacao */
CREATE TABLE situacao (
	id INT NOT NULL IDENTITY(1, 1),
	situacao VARCHAR(30) NOT NULL,
	data_cadastro DATETIME NOT NULL,
	login_cadastro VARCHAR(15) NOT NULL
)
GO

/* cursos */
CREATE TABLE cursos (
	id INT NOT NULL IDENTITY(1, 1),
	nome VARCHAR(200) NOT NULL,
	data_cadastro DATETIME NOT NULL,
	login_cadastro VARCHAR(15) NOT NULL
)
GO

/* turma */
CREATE TABLE turma (
	id INT NOT NULL IDENTITY(1, 1),
	id_aluno INT NOT NULL,
	id_curso INT NOT NULL,
	valor_turma DECIMAL(15, 2) NOT NULL,
	desconto DECIMAL(3, 2) NOT NULL,
	data_inicio DATE NOT NULL,
	data_termino DATE,
	data_cadastro DATETIME NOT NULL,
	login_cadastro VARCHAR(15) NOT NULL
)
GO

CREATE TABLE registro_presenca(
	id_turma INT NOT NULL,
	id_aluno INT NOT NULL,
	id_situacao INT NOT NULL,
	data_presenca DATE NOT NULL,
	data_cadastro DATE NOT NULL,
	login_cadastro VARCHAR(15) NOT NULL
)
GO

---------------------- ADICIONANDO AS PRIMARY KEYS ----------------------

/* Adicionando Primary Key na tabela ALUNOS */
ALTER TABLE alunos
ADD CONSTRAINT PK_alunos 
PRIMARY KEY (id)
GO

/* Adicionando Primary Key na tabela CURSOS */
ALTER TABLE cursos
ADD CONSTRAINT pk_cursos
PRIMARY KEY (id)
GO

/* Adicionando Primary Key na tabela TURMA */
ALTER TABLE turma
ADD CONSTRAINT pk_turma 
PRIMARY KEY (id) 
GO

/* Adicionando Primary Key na tabela SITUACAO */
ALTER TABLE situacao
ADD CONSTRAINT pk_situacao 
PRIMARY KEY (id)
GO

---------------------- ADICIONANDO AS FOREIGN KEYS ----------------------

/* Adicionando Foreign Key de aluno na tabela TURMA */
ALTER TABLE turma
ADD CONSTRAINT fk_aluno
FOREIGN KEY (id_aluno)
REFERENCES alunos (id)
GO

/* Adicionando Foreign Key de curso na tabela TURMA */
ALTER TABLE turma
ADD CONSTRAINT fk_cursos
FOREIGN KEY (id_curso)
REFERENCES cursos (id)
GO

/* Adicionando Foreign Key na tabela REGISTRO_PRESENCA */

-- turma
ALTER TABLE registro_presenca
ADD CONSTRAINT fk_turmaRP
FOREIGN KEY (id_turma)
REFERENCES turma (id)
GO

-- alunos
ALTER TABLE registro_presenca
ADD CONSTRAINT fk_alunoRP
FOREIGN KEY (id_aluno)
REFERENCES alunos (id)
GO

-- situacao
ALTER TABLE registro_presenca
ADD CONSTRAINT fk_situacaoRP
FOREIGN KEY (id_situacao)
REFERENCES situacao (id)
GO


---------------------- MODIFICANDO AS COLUNAS ----------------------
sp_rename 'situacao.nome_situacao', 'situacao', 'COLUMN'
GO

SELECT * FROm situacao