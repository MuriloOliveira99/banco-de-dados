CREATE DATABASE sistema_lms
GO

USE sistema_lms
GO

CREATE TABLE Usuario (
    ID INT IDENTITY(1, 1) NOT NULL,
    [Login] VARCHAR(20) NOT NULL,
    Senha VARBINARY(30) NOT NULL, 
    DtExpiracao DATETIME NOT NULL, 
    CONSTRAINT PK_Usuario PRIMARY KEY(ID),
    CONSTRAINT UQ_UsuarioLogin UNIQUE([login])
)
ALTER TABLE Usuario
ADD CONSTRAINT DF_UsuarioDtExp DEFAULT '19000101' FOR DtExpiracao
GO

CREATE TABLE Coordenador (
    ID INT IDENTITY(1, 1) NOT NULL,
    idUsuario INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Celular CHAR(13) NOT NULL,
    CONSTRAINT PK_Coordenador PRIMARY KEY(ID),
    CONSTRAINT FK_CoordenadorUsuario FOREIGN KEY(idUsuario) REFERENCES Usuario(ID),
    CONSTRAINT UQ_CoordenadorEmail UNIQUE(Email),
    CONSTRAINT UQ_CoordenadorCelular UNIQUE(Celular)
)
GO

CREATE TABLE Aluno (
    ID INT IDENTITY(1, 1) NOT NULL,
    idUsuario INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Celular CHAR(15) NOT NULL,
    RA CHAR(7) NOT NULL,
    Foto VARBINARY(max) NULL,
    CONSTRAINT PK_Aluno PRIMARY KEY(ID),
    CONSTRAINT FK_AlunoUsuario FOREIGN KEY(idUsuario) REFERENCES Usuario(ID),
    CONSTRAINT UQ_AlunoEmail UNIQUE(Email),
    CONSTRAINT UQ_AlunoCelular UNIQUE(Celular)
)
GO 

CREATE TABLE Professor (
    ID INT IDENTITY(1, 1) NOT NULL,
    idUsuario INT NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Celular CHAR(13) NOT NULL,
    Apelido VARCHAR(50) NOT NULL
    CONSTRAINT PK_Professor PRIMARY KEY(ID),
    CONSTRAINT FK_ProfessorUsuario FOREIGN KEY(idUsuario) REFERENCES Usuario(ID),
    CONSTRAINT UQ_ProfessorEmail UNIQUE(Email),
    CONSTRAINT UQ_ProfessorCelular UNIQUE(Celular)
)
GO 

CREATE TABLE Disciplina (
    ID INT IDENTITY(1, 1) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    [Data] DATETIME NOT NULL,
    [Status] VARCHAR(8) NOT NULL,
    PlanoDeEnsino VARBINARY(max) NOT NULL, 
    CargaHoraria TINYINT NOT NULL, 
    Competencias VARCHAR(500) NOT NULL, 
    Habilidades VARCHAR(1000) NOT NULL,  
    Ementa VARCHAR(300) NOT NULL, 
    ConteudoProgramatico VARCHAR(1000) NOT NULL, 
    BibliografiaBasica VARCHAR(1000) NOT NULL, 
    BibliografiaComplementar VARCHAR(1000) NOT NULL, 
    PercentualPratico TINYINT NOT NULL,
    PercentualTeorico TINYINT NOT NULL,
    IdCoordenador INT NOT NULL,
    CONSTRAINT PK_Disciplina PRIMARY KEY(ID),
    CONSTRAINT UQ_DisciplinaNome UNIQUE(Nome),
    CONSTRAINT CK_DisciplinaStatus CHECK ([status] IN('Aberta', 'Fechada')),
    CONSTRAINT CK_DisciplinaCargaHoraria CHECK(CargaHoraria IN(40, 80)),
    CONSTRAINT CK_DisciplinaPercentualPratico CHECK(PercentualPratico BETWEEN 0 AND 100),
    CONSTRAINT CK_DisciplinaPercentualTeorico CHECK(PercentualTeorico BETWEEN 0 AND 100),
    CONSTRAINT FK_DisciplinaCoordenador FOREIGN KEY(IdCoordenador) REFERENCES Coordenador(ID)
)
GO 
ALTER TABLE Disciplina
ADD CONSTRAINT DF_DisciplinaData DEFAULT GETDATE() FOR [Data]
GO

ALTER TABLE Disciplina
ADD CONSTRAINT DF_DisciplinaStatus DEFAULT 'Aberta' FOR [Status]
GO

CREATE TABLE Curso (
    ID INT IDENTITY(1, 1) NOT NULL,
    Nome VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Curso PRIMARY KEY(ID),
    CONSTRAINT UQ_CursoNome UNIQUE(Nome)
)
GO 
 
CREATE TABLE DisciplinaOfertada (
    ID INT IDENTITY(1, 1) NOT NULL,
    IdCoordenador INT NOT NULL,
    DtInicioMatricula DATE NULL,
    DtFimMatricula DATE NULL,
    IdDisciplina INT NOT NULL,
    IdCurso INT NOT NULL,
    Ano SMALLINT NOT NULL,
    Semestre CHAR(1) NOT NULL,
    Turma CHAR(1) NOT NULL,
    IdProfessor INT NULL,
    Metodologia VARCHAR(600) NULL,
    Recursos VARCHAR(300) NULL,
    CriterioAvaliacao VARCHAR(1000) NULL,
	PlanoDeAulas VARBINARY(max) NULL,
    CONSTRAINT PK_DisciplinaOfertada PRIMARY KEY(ID),
    CONSTRAINT FK_DisciplinaOfertadaCoordenador FOREIGN KEY(IdCoordenador) REFERENCES Coordenador(ID),
    CONSTRAINT FK_DisciplinaOfertadaDisciplina FOREIGN KEY(IdDisciplina) REFERENCES Disciplina(ID),
	CONSTRAINT UQ_DisciplinaOfertada UNIQUE(IdDisciplina, IdCurso, Ano, Semestre, Turma),
    CONSTRAINT FK_DisciplinaOfertadaCurso FOREIGN KEY(IdCurso) REFERENCES Curso(ID),
	CONSTRAINT CK_DisciplinaOfertadaAno CHECK(Ano BETWEEN 1900 AND 2100),
	CONSTRAINT CK_DisciplinaOfertadaSemestre CHECK(Semestre IN('1', '2')),
	CONSTRAINT CK_DisciplinaOfertadaTurma CHECK(Turma LIKE '[A-Z]'),
	CONSTRAINT FK_DisciplinaOfertadaProfessor FOREIGN KEY(IdProfessor) REFERENCES Professor(ID) 
)
GO 

CREATE TABLE SolicitacaoMatricula (
	ID INT IDENTITY(1, 1) NOT NULL,
	IdAluno INT NOT NULL,
	IdDisciplinaOfertada INT NOT NULL,
	DtSolicitacao DATETIME NOT NULL,
	IdCoordenador INT NULL,
	[Status] CHAR(10) NULL,
	CONSTRAINT PK_SolicitacaoMatricula PRIMARY KEY(ID),
	CONSTRAINT FK_SolicitacaoMatriculaAluno FOREIGN KEY(IdAluno) REFERENCES Aluno(ID),
	CONSTRAINT UQ_SolicitacaoMatriculaAluno UNIQUE(IdAluno),
	CONSTRAINT FK_SolicitacaoMatriculaDO FOREIGN KEY(IdDisciplinaOfertada) REFERENCES DisciplinaOfertada(ID),
	CONSTRAINT FK_SolicitacaoMatriculaCoordenador FOREIGN KEY(IdCoordenador) REFERENCES Coordenador(ID),
	CONSTRAINT CK_SolicitacaoMatriculaStatus CHECK([Status] IN('Solicitada', 'Aprovada', 'Rejeitada', 'Cancelada'))
)
GO
ALTER TABLE SolicitacaoMatricula
ADD CONSTRAINT DF_SolicitacaoMatriculaDt DEFAULT GETDATE() FOR DtSolicitacao
GO

ALTER TABLE SolicitacaoMatricula
ADD CONSTRAINT DF_SolicitacaoMatriculaStatus DEFAULT 'Solicitada' FOR [Status]
GO

CREATE TABLE Atividade (
		ID INT IDENTITY(1, 1) NOT NULL,
		Titulo VARCHAR(100) NOT NULL,
		Descricao VARCHAR(300) NULL,
		Conteudo VARCHAR(300) NOT NULL,
		Tipo VARCHAR(14) NOT NULL,
		Extras VARBINARY(max) NULL,
		IdProfessor INT NOT NULL,
		CONSTRAINT PK_Atividade PRIMARY KEY(ID),
		CONSTRAINT UQ_AtividadeTitulo UNIQUE(Titulo),
		CONSTRAINT CK_AtividadeTipo CHECK(Tipo IN('Resposta Aberta', 'Teste')),
		CONSTRAINT FK_AtividadeProfessor FOREIGN KEY(IdProfessor) REFERENCES Professor(ID)
)
GO

CREATE TABLE AtividadeVinculada (
	ID INT IDENTITY(1, 1) NOT NULL,
	IdAtividade INT NOT NULL,
	IdProfessor INT NOT NULL,
	IdDisciplinaOfertada INT NOT NULL,
	Rotulo CHAR(3) NOT NULL,
	[Status] VARCHAR(15) NOT NULL,
	DtInicioRespostas DATETIME NOT NULL,
	DtFimRespostas DATETIME NOT NULL,
	CONSTRAINT PK_AtividadeVinculada PRIMARY KEY(ID),
	CONSTRAINT FK_AtividadeVinculadaAtividade FOREIGN KEY(IdAtividade) REFERENCES Atividade(ID),
	CONSTRAINT UQ_AtividadeVinculada UNIQUE(IdAtividade, IdDisciplinaOfertada, Rotulo),
	CONSTRAINT FK_AtividadeVinculadaProfessor FOREIGN KEY(IdProfessor) REFERENCES Professor(ID),
	CONSTRAINT FK_AtividadeVinculadaDO FOREIGN KEY(IdDisciplinaOfertada) REFERENCES DisciplinaOfertada(ID),
	CONSTRAINT CK_AtividadeVinculadaRotulo CHECK(Rotulo IN('AC1', 'AC2', 'AC3', 'AC4', 'AC5')),
	CONSTRAINT CK_AtividadeVinculadaDtInicioFim CHECK(DtInicioRespostas < DtFimRespostas),
	CONSTRAINT CK_AtividadeVinculadaStatus CHECK([Status] IN('Disponibilizada', 'Aberta', 'Fechada', 'Encerrada', 'Prorrogada'))
)
GO
ALTER TABLE AtividadeVinculada
ADD CONSTRAINT DF_AtividadeVinculadaDtInicio DEFAULT GETDATE() FOR DtInicioRespostas
GO

ALTER TABLE AtividadeVinculada
ADD CONSTRAINT DF_AtividadeVinculadaDtFim DEFAULT GETDATE() FOR DtFimRespostas
GO

CREATE TABLE Entrega (
	ID INT IDENTITY(1, 1) NOT NULL,
	IdAluno INT NOT NULL,
	IdAtividadeVinculada INT NOT NULL,
	Titulo VARCHAR(100) NOT NULL,
	Resposta VARBINARY(max) NOT NULL,
	DtEntrega DATETIME NOT NULL,
	[Status] VARCHAR(9) NOT NULL,
	IdProfessor INT NULL,
	Nota DECIMAL(3, 2) NULL,
	DtAvaliacao DATETIME NULL,
	Obs VARCHAR(300) NULL,
	CONSTRAINT PK_Entrega PRIMARY KEY(ID),
	CONSTRAINT FK_EntregaAluno FOREIGN KEY(IdAluno) REFERENCES Aluno(ID),
	CONSTRAINT FK_EntregaAtividadeVinculada FOREIGN KEY(IdAtividadeVinculada) REFERENCES AtividadeVinculada(ID),
	CONSTRAINT UQ_Entrega UNIQUE(IdALuno, IdAtividadeVinculada),
	CONSTRAINT CK_EntregaStatus CHECK([Status] IN('Entregue', 'Corrigido')),
	CONSTRAINT FK_EntregaProfessor FOREIGN KEY(IdProfessor) REFERENCES Professor(ID),
	CONSTRAINT CK_EntregaNotas CHECK(Nota BETWEEN 0.00 AND 10.00)
)
GO
ALTER TABLE Entrega
ADD CONSTRAINT DF_EntregaDtEntrega DEFAULT GETDATE() FOR DtEntrega
GO

ALTER TABLE Entrega
ADD CONSTRAINT DF_EntregaStatus DEFAULT 'Entregue' FOR [Status]
GO

CREATE TABLE Mensagem ( 
	ID INT IDENTITY(1, 1) NOT NULL,
	IdAluno INT NOT NULL,
	IdProfessor INT NOT NULL,
	Assunto VARCHAR(100) NOT NULL,
	Referencia VARCHAR(300) NOT NULL,
	Conteudo VARCHAR(300) NOT NULL,
	[Status] VARCHAR(10) NOT NULL,
	DtEnvio DATETIME NOT NULL,
	DtResposta DATETIME NULL,
	Resposta VARCHAR(300) NULL,
	CONSTRAINT PK_Mensagem PRIMARY KEY(ID),
	CONSTRAINT FK_MensagemAluno FOREIGN KEY(IdAluno) REFERENCES Aluno(ID),
	CONSTRAINT FK_MensagemProfessor FOREIGN KEY(IdProfessor) REFERENCES Professor(ID),
	CONSTRAINT CK_MensagemStatus CHECK([Status] IN('Enviado', 'Lido', 'Respondido'))
)
GO
ALTER TABLE Mensagem
ADD CONSTRAINT DF_MensagemStatus DEFAULT 'Enviado' FOR [Status]
GO

ALTER TABLE Mensagem
ADD CONSTRAINT DF_MensagemDtEnvio DEFAULT GETDATE() FOR DtEnvio
GO

ALTER TABLE Mensagem
ADD CONSTRAINT DF_MensagemDtResposta DEFAULT GETDATE() FOR DtResposta
GO