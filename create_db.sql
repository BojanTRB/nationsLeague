USE master
GO
-- Prevent 'database is in use' error when deleting.
IF EXISTS (SELECT 1 FROM sys.databases WHERE [name] = N'SoccerLeague')
BEGIN
    ALTER DATABASE SoccerLeague SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SoccerLeague;
END;
GO
CREATE DATABASE SoccerLeague
GO
USE SoccerLeague
GO

DROP TABLE IF EXISTS Goals;
DROP TABLE IF EXISTS TeamPlayer;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS TeamTrainer;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS Team;
DROP TABLE IF EXISTS Trainer;
DROP TABLE IF EXISTS League;

CREATE TABLE League (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	CreatedOn DATE NOT NULL,
);

CREATE TABLE Team (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL UNIQUE,
	LeagueId INTEGER,
	FOREIGN KEY (LeagueId) REFERENCES League(Id)
);

CREATE TABLE Trainer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	BirthDate DATE NOT NULL,
	Nation VARCHAR(200)
);

CREATE TABLE Player (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	BirthDate DATE NOT NULL,
	Nation VARCHAR(200)
);

CREATE TABLE TeamTrainer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	TrainerFrom DATE NOT NULL,
	TrainerTo DATE,
	TrainerId INTEGER,
	TeamId INTEGER,
	FOREIGN KEY (TrainerId) REFERENCES Trainer(Id),
	FOREIGN KEY (TeamId) REFERENCES Team(Id)
);

CREATE TABLE Game (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	GameDay INTEGER NOT NULL,
	GameDate DATE NOT NULL,
	HomeTeam INTEGER NOT NULL,
	AwayTeam INTEGER NOT NULL,
	FOREIGN KEY (HomeTeam) REFERENCES Team(Id),
	FOREIGN KEY (AwayTeam) REFERENCES Team(Id)
);

CREATE TABLE TeamPlayer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	PlayerFrom DATE NOT NULL,
	PlayerTo DATE,
	PlayerId INTEGER,
	TeamId INTEGER,
	FOREIGN KEY (PlayerId) REFERENCES Player(Id),
	FOREIGN KEY (TeamId) REFERENCES Team(Id)
);

CREATE TABLE Goals (
	[Minute] INTEGER,
	GameId INTEGER,
	TeamPlayerId INTEGER,
	PRIMARY KEY ([Minute], GameId),
	FOREIGN KEY (GameId) REFERENCES Game(Id),
	FOREIGN KEY (TeamPlayerId) REFERENCES TeamPlayer(Id)
);

