CREATE DATABASE notas
GO
USE notas

GO
CREATE TABLE aluno(
ra						VARCHAR(30)	NOT NULL,
nome					VARCHAR(30) NOT NULL
PRIMARY KEY(ra)
)

GO
CREATE TABLE disciplina(
codigo					VARCHAR(30)	NOT NULL,
nome					VARCHAR(50) NOT NULL,
sigla					VARCHAR(10)	NOT NULL,
turno					VARCHAR(15)	NOT NULL,
numAulas				INT			NOT NULL
PRIMARY KEY(codigo)
)

GO
CREATE TABLE avaliacao(
codigo					INT			NOT NULL,
tipo					VARCHAR(30) NOT NULL
PRIMARY KEY(codigo)
)

GO
CREATE TABLE faltas(
raAluno					VARCHAR(30)		NOT NULL,
codigoDisciplina		VARCHAR(30)		NOT NULL,
dataf					DATE			NOT NULL,
presenca				VARCHAR(5)		NOT NULL
PRIMARY KEY(dataf)
FOREIGN KEY(raAluno) REFERENCES aluno (ra),
FOREIGN KEY(codigoDisciplina) REFERENCES disciplina (codigo)
)

GO
CREATE TABLE notas(
raAluno					VARCHAR(30)		NOT NULL,
codigoDisciplina		VARCHAR(30)		NOT NULL,
codigoAvaliacao			INT				NOT NULL,
nota					DECIMAL(2,1)	NOT NULL
FOREIGN KEY(raAluno) REFERENCES aluno (ra),
FOREIGN KEY(codigoDisciplina) REFERENCES disciplina (codigo),
FOREIGN KEY(codigoAvaliacao) REFERENCES avaliacao (codigo)
)

GO
CREATE TABLE cod(
codigo	VARCHAR(30)
)

GO
INSERT INTO disciplina VALUES
('4203-010','Arquitetura e Organização de Computadores','AOC','T',4),
('4203-020','Arquitetura e Organização de Computadores','AOC','N',4),
('4208-010','Laboratório de Hardware','LH','T',2),
('4226-004','Banco de Dados','BD','T',4),
('4213-003','Sistemas Operacionais I','SO1','T',4),
('4213-013','Sistemas Operacionais I','SO1','N',4),
('4233-005','Laboratório de Banco de Dados','LBD','T',4),
('5005-220','Métodos Para a Produção do Conhecimento','MPC','T',2)

GO
INSERT INTO avaliacao VALUES
(1,'P1'),
(2,'P2'),
(3,'P3'),
(4,'T'),
(5,'Monografia resumida'),
(6,'Monografia completa'),
(7,'Exame final')

GO
INSERT INTO aluno VALUES 
('1110482112029','Vitor Kenji'),
('1110482112022','Bryan Oliveira')


SELECT * FROM aluno
SELECT * FROM disciplina
SELECT * FROM avaliacao
SELECT * FROM faltas
SELECT * FROM notas

SELECT codigo, nome, sigla, turno, numAulas FROM disciplina
SELECT codigo, tipo FROM avaliacao

SELECT codigo FROM avaliacao
WHERE tipo = 'P1'

SELECT a.nome As Aluno, d.nome As Materia, d.turno, av.tipo, n.nota 
FROM aluno a, disciplina d, avaliacao av, notas n
WHERE a.ra = 1110482112029
	AND n.raAluno = a.ra
	AND n.codigoDisciplina = d.codigo
	AND n.codigoAvaliacao = av.codigo

SELECT a.nome As Aluno, d.nome As Disciplina, f.dataf As Data_Falta, f.presenca
FROM aluno a, disciplina d, faltas f
WHERE a.ra = 1110482112029
	AND f.raAluno = a.ra
	AND f.codigoDisciplina = d.codigo




-----------------------CURSORES-NOTAS----------------------

SELECT * FROM fn_notas_A('4203-010')

GO
CREATE FUNCTION fn_notas_A(@codD VARCHAR(30))
RETURNS @tabela TABLE(
RA_Aluno			VARCHAR(30),
Nome_Aluno			VARCHAR(30),
P1					DECIMAL(2,1),
P2					DECIMAL(2,1),
T					DECIMAL(2,1),
Media_Final			DECIMAL(2,1),
Situacao			VARCHAR(9)
)
AS
BEGIN
	DECLARE 
		@Avaliacao		VARCHAR(30),
		@RA_Aluno		VARCHAR(30),
		@Nome_Aluno		VARCHAR(30),
		@Nota			DECIMAL(2,1),
		@Situacao		VARCHAR(9),
		@P1				DECIMAL(2,1),
		@P2				DECIMAL(2,1),
		@T				DECIMAL(2,1),
		@Media_Final	DECIMAL(2,1)
 
	DECLARE cnA CURSOR FOR 
	SELECT DISTINCT a.ra
	FROM aluno a, notas n, disciplina d, avaliacao av
	WHERE @codD = d.codigo
		AND n.codigoDisciplina = d.codigo
		AND n.codigoAvaliacao = av.codigo
		AND n.raAluno = a.ra
 
	OPEN cnA
	FETCH NEXT FROM cnA INTO @RA_Aluno
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@RA_Aluno = a.ra, 
				@Nome_Aluno = a.nome
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra

		SELECT @P1 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P1'

		SELECT @P2 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P2'

		SELECT @T = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'T'

		SET @Media_Final = (@P1 * 0.3) + (@P2 * 0.5) + (@T * 0.2)

		IF(@Media_Final > 6)
		BEGIN
			SET @Situacao = 'APROVADO'
		END
		IF(@Media_Final < 3)
		BEGIN
			SET @Situacao = 'REPROVADO'
		END
		IF(@Media_Final > 3 AND @Media_Final < 6)
		BEGIN
			SET @Situacao = 'EXAME'
		END
		INSERT INTO @tabela VALUES (@RA_Aluno, @Nome_Aluno, @P1, @P2, @T, @Media_Final, @Situacao)
		FETCH NEXT FROM cnA INTO @RA_Aluno
	END
	CLOSE cnA
	DEALLOCATE cnA
	RETURN
END

GO
CREATE FUNCTION fn_notas_B(@codD VARCHAR(30))
RETURNS @tabela TABLE(
RA_Aluno			VARCHAR(30),
Nome_Aluno			VARCHAR(30),
P1					DECIMAL(2,1),
P2					DECIMAL(2,1),
T					DECIMAL(2,1),
Media_Final			DECIMAL(2,1),
Situacao			VARCHAR(9)
)
AS
BEGIN
	DECLARE 
		@Avaliacao		VARCHAR(30),
		@RA_Aluno		VARCHAR(30),
		@Nome_Aluno		VARCHAR(30),
		@Nota			DECIMAL(2,1),
		@Situacao		VARCHAR(9),
		@P1				DECIMAL(2,1),
		@P2				DECIMAL(2,1),
		@T				DECIMAL(2,1),
		@Media_Final	DECIMAL(2,1)
 
	DECLARE cnB CURSOR FOR 
	SELECT DISTINCT a.ra
	FROM aluno a, notas n, disciplina d, avaliacao av
	WHERE @codD = d.codigo
		AND n.codigoDisciplina = d.codigo
		AND n.codigoAvaliacao = av.codigo
		AND n.raAluno = a.ra
 
	OPEN cnB
	FETCH NEXT FROM cnB INTO @RA_Aluno
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@RA_Aluno = a.ra, 
				@Nome_Aluno = a.nome
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra

		SELECT @P1 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P1'

		SELECT @P2 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P2'

		SELECT @T = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'T'

		SET @Media_Final = (@P1 * 0.35) + (@P2 * 0.35) + (@T * 0.3)

		IF(@Media_Final > 6)
		BEGIN
			SET @Situacao = 'APROVADO'
		END
		IF(@Media_Final < 3)
		BEGIN
			SET @Situacao = 'REPROVADO'
		END
		IF(@Media_Final > 3 AND @Media_Final < 6)
		BEGIN
			SET @Situacao = 'EXAME'
		END

		INSERT INTO @tabela VALUES (@RA_Aluno, @Nome_Aluno, @P1, @P2, @T, @Media_Final, @Situacao)
		FETCH NEXT FROM cnB INTO @RA_Aluno
	END
	CLOSE cnB
	DEALLOCATE cnB
	RETURN
END

GO
CREATE FUNCTION fn_notas_C(@codD VARCHAR(30))
RETURNS @tabela TABLE(
RA_Aluno			VARCHAR(30),
Nome_Aluno			VARCHAR(30),
P1					DECIMAL(2,1),
P2					DECIMAL(2,1),
P3					DECIMAL(2,1),
Media_Final			DECIMAL(2,1),
Situacao			VARCHAR(9)
)
AS
BEGIN
	DECLARE 
		@Avaliacao		VARCHAR(30),
		@RA_Aluno		VARCHAR(30),
		@Nome_Aluno		VARCHAR(30),
		@Nota			DECIMAL(2,1),
		@Situacao		VARCHAR(9),
		@P1				DECIMAL(2,1),
		@P2				DECIMAL(2,1),
		@P3				DECIMAL(2,1),
		@Media_Final	DECIMAL(2,1)
 
	DECLARE cnC CURSOR FOR 
	SELECT DISTINCT a.ra
	FROM aluno a, notas n, disciplina d, avaliacao av
	WHERE @codD = d.codigo
		AND n.codigoDisciplina = d.codigo
		AND n.codigoAvaliacao = av.codigo
		AND n.raAluno = a.ra
 
	OPEN cnC
	FETCH NEXT FROM cnC INTO @RA_Aluno
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@RA_Aluno = a.ra, 
				@Nome_Aluno = a.nome
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra

		SELECT @P1 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P1'

		SELECT @P2 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P2'

		SELECT @P3 = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'P3'

		SET @Media_Final = (@P1 * 0.33) + (@P2 * 0.33) + (@P3 * 0.33)

		IF(@Media_Final > 6)
		BEGIN
			SET @Situacao = 'APROVADO'
		END
		IF(@Media_Final < 3)
		BEGIN
			SET @Situacao = 'REPROVADO'
		END
		IF(@Media_Final > 3 AND @Media_Final < 6)
		BEGIN
			SET @Situacao = 'EXAME'
		END

		INSERT INTO @tabela VALUES (@RA_Aluno, @Nome_Aluno, @P1, @P2, @P3, @Media_Final, @Situacao)
		FETCH NEXT FROM cnC INTO @RA_Aluno
	END
	CLOSE cnC
	DEALLOCATE cnC
	RETURN
END

GO
CREATE FUNCTION fn_notas_D(@codD VARCHAR(30))
RETURNS @tabela TABLE(
RA_Aluno			VARCHAR(30),
Nome_Aluno			VARCHAR(30),
MonografiaResumida	DECIMAL(2,1),
MonografiaCompleta	DECIMAL(2,1),
Media_Final			DECIMAL(2,1),
Situacao			VARCHAR(9)
)
AS
BEGIN
	DECLARE 
		@Avaliacao		VARCHAR(30),
		@RA_Aluno		VARCHAR(30),
		@Nome_Aluno		VARCHAR(30),
		@Nota			DECIMAL(2,1),
		@Situacao		VARCHAR(9),
		@MonografiaResumida	DECIMAL(2,1),
		@MonografiaCompleta DECIMAL(2,1),
		@Media_Final	DECIMAL(2,1)
 
	DECLARE cnD CURSOR FOR 
	SELECT DISTINCT a.ra
	FROM aluno a, notas n, disciplina d, avaliacao av
	WHERE @codD = d.codigo
		AND n.codigoDisciplina = d.codigo
		AND n.codigoAvaliacao = av.codigo
		AND n.raAluno = a.ra
 
	OPEN cnD
	FETCH NEXT FROM cnD INTO @RA_Aluno
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@RA_Aluno = a.ra, 
				@Nome_Aluno = a.nome
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra

		SELECT @MonografiaResumida = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'Monografia resumida'

		SELECT @MonografiaCompleta = n.nota
		FROM aluno a, notas n, disciplina d, avaliacao av
		WHERE @codD = d.codigo
			AND n.codigoDisciplina = d.codigo
			AND n.codigoAvaliacao = av.codigo
			AND n.raAluno = a.ra
			AND a.ra = @RA_Aluno
			AND av.tipo = 'Monografia completa'

		SET @Media_Final = (@MonografiaResumida * 0.2) + (@MonografiaCompleta * 0.8)

		IF(@Media_Final > 6)
		BEGIN
			SET @Situacao = 'APROVADO'
		END
		IF(@Media_Final < 3)
		BEGIN
			SET @Situacao = 'REPROVADO'
		END
		IF(@Media_Final > 3 AND @Media_Final < 6)
		BEGIN
			SET @Situacao = 'EXAME'
		END

		INSERT INTO @tabela VALUES (@RA_Aluno, @Nome_Aluno, @MonografiaResumida, @MonografiaCompleta, @Media_Final, @Situacao)
		FETCH NEXT FROM cnD INTO @RA_Aluno
	END
	CLOSE cnD
	DEALLOCATE cnD
	RETURN
END

-----------------------CURSORES-FALTAS----------------------------

SELECT * FROM fn_faltas('4203-010')

GO
CREATE FUNCTION fn_faltas(@codD VARCHAR(30))
RETURNS @tabela TABLE(
RA_Aluno			VARCHAR(30),
Nome_Aluno			VARCHAR(30),
Data1				VARCHAR(5),
Data2				VARCHAR(5),
Data3				VARCHAR(5),
Data4				VARCHAR(5),
Data5				VARCHAR(5),
Data6				VARCHAR(5),
Data7				VARCHAR(5),
Data8				VARCHAR(5),
Data9				VARCHAR(5),
Data10				VARCHAR(5),
Data11				VARCHAR(5),
Data12				VARCHAR(5),
Data13				VARCHAR(5),
Data14				VARCHAR(5),
Data15				VARCHAR(5),
Data16				VARCHAR(5),
Data17				VARCHAR(5),
Data18				VARCHAR(5),
Data19				VARCHAR(5),
Data20				VARCHAR(5),
Total_Faltas		INT
)
AS
BEGIN
	DECLARE 
		@RA_Aluno		VARCHAR(30),
		@Nome_Aluno		VARCHAR(30),
		@Data1			VARCHAR(5),
		@Data2			VARCHAR(5),
		@Data3			VARCHAR(5),
		@Data4			VARCHAR(5),
		@Data5			VARCHAR(5),
		@Data6			VARCHAR(5),
		@Data7			VARCHAR(5),
		@Data8			VARCHAR(5),
		@Data9			VARCHAR(5),
		@Data10			VARCHAR(5),
		@Data11			VARCHAR(5),
		@Data12			VARCHAR(5),
		@Data13			VARCHAR(5),
		@Data14			VARCHAR(5),
		@Data15			VARCHAR(5),
		@Data16			VARCHAR(5),
		@Data17			VARCHAR(5),
		@Data18			VARCHAR(5),
		@Data19			VARCHAR(5),
		@Data20			VARCHAR(5),
		@Total_Faltas	INT
 
	DECLARE cf CURSOR FOR 
	SELECT DISTINCT a.ra
	FROM aluno a, disciplina d, faltas f
	WHERE @codD = d.codigo
		AND d.codigo = f.codigoDisciplina
		AND a.ra = f.raAluno
 
	OPEN cf
	FETCH NEXT FROM cf INTO @RA_Aluno
	WHILE @@FETCH_STATUS = 0
	BEGIN

		SELECT	@RA_Aluno = a.ra, 
				@Nome_Aluno = a.nome
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno

		SELECT @Data1 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-02-06'

		SELECT @Data2 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-02-13'

		SELECT @Data3 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-02-20'

		SELECT @Data4 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-02-27'

		SELECT @Data5 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-03-06'

		SELECT @Data6 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-03-13'

		SELECT @Data7 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-03-20'

		SELECT @Data8 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-03-27'

		SELECT @Data9 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-04-03'

		SELECT @Data10 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-04-10'

		SELECT @Data11 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-04-17'

		SELECT @Data12 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-04-24'

		SELECT @Data13 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-05-01'

		SELECT @Data14 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-05-08'

		SELECT @Data15 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-05-15'

		SELECT @Data16 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-05-22'

		SELECT @Data17 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-05-29'

		SELECT @Data18 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-06-05'

		SELECT @Data19 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-06-12'

		SELECT @Data20 = f.presenca
		FROM aluno a, disciplina d, faltas f
		WHERE @codD = d.codigo
			AND d.codigo = f.codigoDisciplina
			AND a.ra = f.raAluno
			AND @RA_Aluno = a.ra
			AND f.dataf = '2023-06-19'

		INSERT INTO @tabela VALUES (@RA_Aluno, @Nome_Aluno, @Data1, @Data2, @Data3, @Data4, 
			@Data5, @Data6, @Data7, @Data8, @Data9, @Data10, @Data11, @Data12, @Data13, @Data14, @Data15, 
			@Data16, @Data17, @Data18, @Data19, @Data20, @Total_Faltas)
		FETCH NEXT FROM cf INTO @RA_Aluno
	END
	CLOSE cf
	DEALLOCATE cf
	RETURN
END