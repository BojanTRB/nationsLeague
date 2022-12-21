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

CREATE TABLE League (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	CreatedOn DATE NOT NULL,
);

CREATE TABLE Team (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	Wins INTEGER NOT NULL,
	Draws INTEGER NOT NULL,
	Losses INTEGER NOT NULL
);

CREATE TABLE Trainer (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	birthdate DATE NOT NULL
);

CREATE TABLE PLAYER (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	[Name] VARCHAR(200) NOT NULL,
	birthdate DATE NOT NULL,
	nation VARCHAR(200) NOT NULL,
);

CREATE TABLE Game (
	Id INTEGER IDENTITY(1,1) PRIMARY KEY,
	gameDay INTEGER NOT NULL,
	gameDate DATE NOT NULL,
	goalsHomeTeam INTEGER NOT NULL,
	goalsAwayTeam INTEGER NOT NULL,
	homeTeam INTEGER,
	awayTeam INTEGER,
);

