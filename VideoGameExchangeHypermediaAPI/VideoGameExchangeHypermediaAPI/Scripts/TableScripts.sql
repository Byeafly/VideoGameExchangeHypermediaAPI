IF OBJECT_ID('dbo.Trade_Offers', 'U') IS NOT NULL
    DROP TABLE dbo.Trade_Offers;

IF OBJECT_ID('dbo.Video_Games', 'U') IS NOT NULL
    DROP TABLE dbo.Video_Games;

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO


CREATE TABLE dbo.Users
(
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    street_address NVARCHAR(255) NOT NULL
);
GO


CREATE TABLE dbo.Video_Games
(
    game_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    name NVARCHAR(255) NOT NULL,
    publisher NVARCHAR(255) NOT NULL,
    year_published INT NOT NULL,
    system NVARCHAR(100) NOT NULL,
    previous_owners_count INT NULL,
    [condition] NVARCHAR(10) NOT NULL CHECK ([condition] IN ('mint','good','fair','poor')),

    CONSTRAINT FK_VideoGames_Users 
        FOREIGN KEY (user_id)
        REFERENCES dbo.Users(user_id)
        ON DELETE CASCADE
);
GO


CREATE TABLE dbo.Trade_Offers
(
    trade_offer_id INT IDENTITY(1,1) PRIMARY KEY,

    from_user_id INT NOT NULL,
    to_user_id INT NOT NULL,

    requested_game_id INT NOT NULL,
    offered_game_id INT NOT NULL,

    status NVARCHAR(20) NOT NULL 
        CHECK (status IN ('Pending','Accepted','Rejected','Cancelled')),

    created_at DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    responded_at DATETIME2 NULL,

    CONSTRAINT FK_TradeOffers_FromUser
        FOREIGN KEY (from_user_id)
        REFERENCES dbo.Users(user_id)
        ON DELETE NO ACTION,

    CONSTRAINT FK_TradeOffers_ToUser
        FOREIGN KEY (to_user_id)
        REFERENCES dbo.Users(user_id)
        ON DELETE NO ACTION,

    CONSTRAINT FK_TradeOffers_RequestedGame
        FOREIGN KEY (requested_game_id)
        REFERENCES dbo.Video_Games(game_id)
        ON DELETE NO ACTION,

    CONSTRAINT FK_TradeOffers_OfferedGame
        FOREIGN KEY (offered_game_id)
        REFERENCES dbo.Video_Games(game_id)
        ON DELETE NO ACTION
);
GO
