DROP TABLE [Administrator]
go

DROP TABLE [Ponuda]
go

DROP TABLE [Zahtev]
go

DROP TABLE [Voznja]
go

DROP TABLE [Paket]
go

DROP TABLE [Kurir]
go

DROP TABLE [Vozilo]
go

DROP TABLE [Prevoz]
go

DROP TABLE [Korisnik]
go

DROP TABLE [Opstina]
go

DROP TABLE [Grad]
go

CREATE TABLE [Administrator]
( 
	[IdK]                integer  NOT NULL 
)
go

CREATE TABLE [Grad]
( 
	[IdG]                integer  IDENTITY  NOT NULL ,
	[Naziv]              varchar(100)  NOT NULL ,
	[PostBr]             varchar(100)  NOT NULL 
)
go

CREATE TABLE [Korisnik]
( 
	[IdK]                integer  IDENTITY  NOT NULL ,
	[Ime]                varchar(100)  NOT NULL ,
	[Prezime]            varchar(100)  NOT NULL ,
	[KorIme]             varchar(100)  NOT NULL ,
	[Sifra]              varchar(100)  NOT NULL ,
	[BrPoslPaketa]       integer  NOT NULL 
)
go

CREATE TABLE [Kurir]
( 
	[IdK]                integer  NOT NULL ,
	[IdV]                integer  NOT NULL ,
	[BrojIsporPaketa]    integer  NOT NULL ,
	[Profit]             decimal(10,3)  NOT NULL ,
	[Status]             integer  NOT NULL 
	CONSTRAINT [StatusOgranicenje_523499058]
		CHECK  ( Status BETWEEN 0 AND 1 )
)
go

CREATE TABLE [Opstina]
( 
	[IdO]                integer  IDENTITY  NOT NULL ,
	[Naziv]              varchar(100)  NOT NULL ,
	[KordX]              integer  NOT NULL ,
	[KordY]              integer  NOT NULL ,
	[IdG]                integer  NOT NULL 
)
go

CREATE TABLE [Paket]
( 
	[Cena]               decimal(10,3)  NOT NULL ,
	[Vreme]              datetime  NOT NULL ,
	[IdP]                integer  NOT NULL ,
	[IdK]                integer  NOT NULL 
)
go

CREATE TABLE [Ponuda]
( 
	[Procena]            decimal(10,3)  NOT NULL ,
	[IdK]                integer  NOT NULL ,
	[IdP]                integer  NOT NULL ,
	[IdPon]              integer  IDENTITY  NOT NULL 
)
go

CREATE TABLE [Prevoz]
( 
	[IdP]                integer  IDENTITY  NOT NULL ,
	[IdO1]               integer  NOT NULL ,
	[IdO2]               integer  NOT NULL ,
	[IdK]                integer  NOT NULL ,
	[TipPaketa]          integer  NOT NULL 
	CONSTRAINT [TipOgranicenje_391587015]
		CHECK  ( TipPaketa BETWEEN 0 AND 2 ),
	[Tezina]             decimal(10,3)  NOT NULL ,
	[Status]             integer  NOT NULL 
	CONSTRAINT [StatusIsporukeOgranicenje_461900032]
		CHECK  ( Status BETWEEN 0 AND 3 )
)
go

CREATE TABLE [Vozilo]
( 
	[IdV]                integer  IDENTITY  NOT NULL ,
	[RegBr]              varchar(7)  NOT NULL ,
	[TipGoriva]          integer  NOT NULL 
	CONSTRAINT [TipOgranicenje_741616320]
		CHECK  ( TipGoriva BETWEEN 0 AND 2 ),
	[Potrosnja]          decimal(10,3)  NOT NULL 
)
go

CREATE TABLE [Voznja]
( 
	[IdP]                integer  NOT NULL 
)
go

CREATE TABLE [Zahtev]
( 
	[IdK]                integer  NOT NULL ,
	[IdV]                integer  NOT NULL 
)
go

ALTER TABLE [Administrator]
	ADD CONSTRAINT [XPKAdministrator] PRIMARY KEY  CLUSTERED ([IdK] ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XPKGrad] PRIMARY KEY  CLUSTERED ([IdG] ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XAK1Grad] UNIQUE ([PostBr]  ASC)
go

ALTER TABLE [Grad]
	ADD CONSTRAINT [XAK2Grad] UNIQUE ([Naziv]  ASC)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XPKKorisnik] PRIMARY KEY  CLUSTERED ([IdK] ASC)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XAK1Korisnik] UNIQUE ([KorIme]  ASC)
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [XPKKurir] PRIMARY KEY  CLUSTERED ([IdK] ASC)
go

ALTER TABLE [Opstina]
	ADD CONSTRAINT [XPKOpstina] PRIMARY KEY  CLUSTERED ([IdO] ASC)
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [XPKPaket] PRIMARY KEY  CLUSTERED ([IdP] ASC)
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [XPKPonuda] PRIMARY KEY  CLUSTERED ([IdPon] ASC)
go

ALTER TABLE [Prevoz]
	ADD CONSTRAINT [XPKPrevoz] PRIMARY KEY  CLUSTERED ([IdP] ASC)
go

ALTER TABLE [Vozilo]
	ADD CONSTRAINT [XPKVozilo] PRIMARY KEY  CLUSTERED ([IdV] ASC)
go

ALTER TABLE [Vozilo]
	ADD CONSTRAINT [XAK1Vozilo] UNIQUE ([RegBr]  ASC)
go

ALTER TABLE [Voznja]
	ADD CONSTRAINT [XPKVoznja] PRIMARY KEY  CLUSTERED ([IdP] ASC)
go

ALTER TABLE [Zahtev]
	ADD CONSTRAINT [XPKZahtev] PRIMARY KEY  CLUSTERED ([IdK] ASC)
go


ALTER TABLE [Administrator]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([IdK]) REFERENCES [Korisnik]([IdK])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([IdK]) REFERENCES [Korisnik]([IdK])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go

ALTER TABLE [Kurir]
	ADD CONSTRAINT [R_4] FOREIGN KEY ([IdV]) REFERENCES [Vozilo]([IdV])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Opstina]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([IdG]) REFERENCES [Grad]([IdG])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Paket]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([IdP]) REFERENCES [Prevoz]([IdP])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Paket]
	ADD CONSTRAINT [R_16] FOREIGN KEY ([IdK]) REFERENCES [Kurir]([IdK])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([IdK]) REFERENCES [Kurir]([IdK])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Ponuda]
	ADD CONSTRAINT [R_11] FOREIGN KEY ([IdP]) REFERENCES [Prevoz]([IdP])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Prevoz]
	ADD CONSTRAINT [R_5] FOREIGN KEY ([IdO1]) REFERENCES [Opstina]([IdO])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Prevoz]
	ADD CONSTRAINT [R_6] FOREIGN KEY ([IdO2]) REFERENCES [Opstina]([IdO])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go

ALTER TABLE [Prevoz]
	ADD CONSTRAINT [R_7] FOREIGN KEY ([IdK]) REFERENCES [Korisnik]([IdK])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Voznja]
	ADD CONSTRAINT [R_21] FOREIGN KEY ([IdP]) REFERENCES [Paket]([IdP])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


ALTER TABLE [Zahtev]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([IdK]) REFERENCES [Korisnik]([IdK])
		ON DELETE NO ACTION
go

ALTER TABLE [Zahtev]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([IdV]) REFERENCES [Vozilo]([IdV])
		ON DELETE NO ACTION
		ON UPDATE CASCADE
go


CREATE TRIGGER tD_Administrator ON Administrator FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Administrator */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /*   Administrator on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001254b", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdK" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.IdK = IdK AND
        NOT EXISTS (
          SELECT * FROM Administrator
          WHERE
            /* %JoinFKPK(Administrator,," = "," AND") */
            Administrator.IdK = IdK
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Administrator because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Administrator ON Administrator FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Administrator */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdK integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /*   Administrator on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015220", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.IdK = IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Administrator because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Grad ON Grad FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Grad */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Grad  Opstina on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000fa36", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdG" */
    IF EXISTS (
      SELECT * FROM deleted,Opstina
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.IdG = deleted.IdG
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Grad because Opstina exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Grad ON Grad FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Grad */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdG integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Grad  Opstina on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000157d4", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdG" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdG)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdG = inserted.IdG
        FROM inserted
      UPDATE Opstina
      SET
        /*  %JoinFKPK(Opstina,@ins," = ",",") */
        Opstina.IdG = @insIdG
      FROM Opstina,inserted,deleted
      WHERE
        /*  %JoinFKPK(Opstina,deleted," = "," AND") */
        Opstina.IdG = deleted.IdG
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Grad update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Korisnik ON Korisnik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Zahtev on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003315b", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Zahtev"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="IdK" */
    IF EXISTS (
      SELECT * FROM deleted,Zahtev
      WHERE
        /*  %JoinFKPK(Zahtev,deleted," = "," AND") */
        Zahtev.IdK = deleted.IdK
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Zahtev exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Prevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="IdK" */
    IF EXISTS (
      SELECT * FROM deleted,Prevoz
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdK = deleted.IdK
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Prevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Kurir on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdK" */
    DELETE Kurir
      FROM Kurir,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdK = deleted.IdK

    /* erwin Builtin Trigger */
    /*   Administrator on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdK" */
    DELETE Administrator
      FROM Administrator,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.IdK = deleted.IdK


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Korisnik ON Korisnik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdK integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Prevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003d587", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="IdK" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdK = inserted.IdK
        FROM inserted
      UPDATE Prevoz
      SET
        /*  %JoinFKPK(Prevoz,@ins," = ",",") */
        Prevoz.IdK = @insIdK
      FROM Prevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdK = deleted.IdK
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdK" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdK = inserted.IdK
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.IdK = @insIdK
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdK = deleted.IdK
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Administrator on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Administrator"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="IdK" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdK = inserted.IdK
        FROM inserted
      UPDATE Administrator
      SET
        /*  %JoinFKPK(Administrator,@ins," = ",",") */
        Administrator.IdK = @insIdK
      FROM Administrator,inserted,deleted
      WHERE
        /*  %JoinFKPK(Administrator,deleted," = "," AND") */
        Administrator.IdK = deleted.IdK
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade  update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kurir ON Kurir FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurir */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurir  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003aa61", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdK" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdK = deleted.IdK
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurir  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdK" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdK = deleted.IdK
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurir because Ponuda exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdV" */
    IF EXISTS (SELECT * FROM deleted,Vozilo
      WHERE
        /* %JoinFKPK(deleted,Vozilo," = "," AND") */
        deleted.IdV = Vozilo.IdV AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,Vozilo," = "," AND") */
            Kurir.IdV = Vozilo.IdV
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because Vozilo exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /*   Kurir on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdK" */
    IF EXISTS (SELECT * FROM deleted,
      WHERE
        /* %JoinFKPK(deleted,," = "," AND") */
        deleted.IdK = IdK AND
        NOT EXISTS (
          SELECT * FROM Kurir
          WHERE
            /* %JoinFKPK(Kurir,," = "," AND") */
            Kurir.IdK = IdK
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurir because  exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kurir ON Kurir FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurir */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdK integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurir  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0004e004", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdK" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdK = inserted.IdK
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.IdK = @insIdK
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdK = deleted.IdK
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdK" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdK = inserted.IdK
        FROM inserted
      UPDATE Ponuda
      SET
        /*  %JoinFKPK(Ponuda,@ins," = ",",") */
        Ponuda.IdK = @insIdK
      FROM Ponuda,inserted,deleted
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdK = deleted.IdK
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Kurir update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdV" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdV)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.IdV = Vozilo.IdV
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /*   Kurir on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,
        WHERE
          /* %JoinFKPK(inserted,) */
          inserted.IdK = IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurir because  does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Opstina ON Opstina FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Opstina */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Opstina  Prevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001d250", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="IdO2" */
    IF EXISTS (
      SELECT * FROM deleted,Prevoz
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdO2 = deleted.IdO
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because Prevoz exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Opstina  Prevoz on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdO1" */
    IF EXISTS (
      SELECT * FROM deleted,Prevoz
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdO1 = deleted.IdO
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Opstina because Prevoz exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Opstina ON Opstina FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Opstina */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdO integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Opstina  Prevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0003d438", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="IdO2" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdO)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdO = inserted.IdO
        FROM inserted
      UPDATE Prevoz
      SET
        /*  %JoinFKPK(Prevoz,@ins," = ",",") */
        Prevoz.IdO2 = @insIdO
      FROM Prevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdO2 = deleted.IdO
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Opstina update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Prevoz on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdO1" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdO)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdO = inserted.IdO
        FROM inserted
      UPDATE Prevoz
      SET
        /*  %JoinFKPK(Prevoz,@ins," = ",",") */
        Prevoz.IdO1 = @insIdO
      FROM Prevoz,inserted,deleted
      WHERE
        /*  %JoinFKPK(Prevoz,deleted," = "," AND") */
        Prevoz.IdO1 = deleted.IdO
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Opstina update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Grad  Opstina on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Grad"
    CHILD_OWNER="", CHILD_TABLE="Opstina"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="IdG" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdG)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Grad
        WHERE
          /* %JoinFKPK(inserted,Grad) */
          inserted.IdG = Grad.IdG
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Opstina because Grad does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Paket ON Paket FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Paket */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Paket  Voznja on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f6a9", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="IdP" */
    IF EXISTS (
      SELECT * FROM deleted,Voznja
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdP = deleted.IdP
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paket because Voznja exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Paket ON Paket FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Paket */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdP integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  Voznja on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00039db6", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="IdP" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdP = inserted.IdP
        FROM inserted
      UPDATE Voznja
      SET
        /*  %JoinFKPK(Voznja,@ins," = ",",") */
        Voznja.IdP = @insIdP
      FROM Voznja,inserted,deleted
      WHERE
        /*  %JoinFKPK(Voznja,deleted," = "," AND") */
        Voznja.IdP = deleted.IdP
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Paket update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdK = Kurir.IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Kurir does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Prevoz  Paket on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdP" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Prevoz
        WHERE
          /* %JoinFKPK(inserted,Prevoz) */
          inserted.IdP = Prevoz.IdP
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paket because Prevoz does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Ponuda ON Ponuda FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Ponuda */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdPon integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Prevoz  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00028795", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdP" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Prevoz
        WHERE
          /* %JoinFKPK(inserted,Prevoz) */
          inserted.IdP = Prevoz.IdP
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because Prevoz does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurir  Ponuda on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurir"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurir
        WHERE
          /* %JoinFKPK(inserted,Kurir) */
          inserted.IdK = Kurir.IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ponuda because Kurir does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Prevoz ON Prevoz FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Prevoz */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Prevoz  Paket on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001c9e2", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdP" */
    IF EXISTS (
      SELECT * FROM deleted,Paket
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdP = deleted.IdP
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Prevoz because Paket exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Prevoz  Ponuda on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdP" */
    IF EXISTS (
      SELECT * FROM deleted,Ponuda
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdP = deleted.IdP
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Prevoz because Ponuda exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Prevoz ON Prevoz FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Prevoz */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdP integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Prevoz  Paket on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="0006018a", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Paket"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="IdP" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdP = inserted.IdP
        FROM inserted
      UPDATE Paket
      SET
        /*  %JoinFKPK(Paket,@ins," = ",",") */
        Paket.IdP = @insIdP
      FROM Paket,inserted,deleted
      WHERE
        /*  %JoinFKPK(Paket,deleted," = "," AND") */
        Paket.IdP = deleted.IdP
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Prevoz update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Prevoz  Ponuda on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Prevoz"
    CHILD_OWNER="", CHILD_TABLE="Ponuda"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="IdP" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdP = inserted.IdP
        FROM inserted
      UPDATE Ponuda
      SET
        /*  %JoinFKPK(Ponuda,@ins," = ",",") */
        Ponuda.IdP = @insIdP
      FROM Ponuda,inserted,deleted
      WHERE
        /*  %JoinFKPK(Ponuda,deleted," = "," AND") */
        Ponuda.IdP = deleted.IdP
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Prevoz update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Prevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdK = Korisnik.IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Prevoz because Korisnik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Prevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="IdO2" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdO2)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.IdO2 = Opstina.IdO
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Prevoz because Opstina does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Opstina  Prevoz on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Opstina"
    CHILD_OWNER="", CHILD_TABLE="Prevoz"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="IdO1" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdO1)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Opstina
        WHERE
          /* %JoinFKPK(inserted,Opstina) */
          inserted.IdO1 = Opstina.IdO
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Prevoz because Opstina does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vozilo ON Vozilo FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vozilo */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vozilo  Zahtev on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001cb4e", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Zahtev"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdV" */
    IF EXISTS (
      SELECT * FROM deleted,Zahtev
      WHERE
        /*  %JoinFKPK(Zahtev,deleted," = "," AND") */
        Zahtev.IdV = deleted.IdV
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Zahtev exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Vozilo  Kurir on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdV" */
    IF EXISTS (
      SELECT * FROM deleted,Kurir
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdV = deleted.IdV
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vozilo because Kurir exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vozilo ON Vozilo FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vozilo */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdV integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  Zahtev on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="000287ce", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Zahtev"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdV" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdV)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdV = inserted.IdV
        FROM inserted
      UPDATE Zahtev
      SET
        /*  %JoinFKPK(Zahtev,@ins," = ",",") */
        Zahtev.IdV = @insIdV
      FROM Zahtev,inserted,deleted
      WHERE
        /*  %JoinFKPK(Zahtev,deleted," = "," AND") */
        Zahtev.IdV = deleted.IdV
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Vozilo  Kurir on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Kurir"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="IdV" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(IdV)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insIdV = inserted.IdV
        FROM inserted
      UPDATE Kurir
      SET
        /*  %JoinFKPK(Kurir,@ins," = ",",") */
        Kurir.IdV = @insIdV
      FROM Kurir,inserted,deleted
      WHERE
        /*  %JoinFKPK(Kurir,deleted," = "," AND") */
        Kurir.IdV = deleted.IdV
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Vozilo update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Voznja ON Voznja FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Voznja */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdP integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Paket  Voznja on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015949", PARENT_OWNER="", PARENT_TABLE="Paket"
    CHILD_OWNER="", CHILD_TABLE="Voznja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="IdP" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdP)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paket
        WHERE
          /* %JoinFKPK(inserted,Paket) */
          inserted.IdP = Paket.IdP
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Voznja because Paket does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tU_Zahtev ON Zahtev FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Zahtev */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insIdK integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vozilo  Zahtev on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000281da", PARENT_OWNER="", PARENT_TABLE="Vozilo"
    CHILD_OWNER="", CHILD_TABLE="Zahtev"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="IdV" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdV)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vozilo
        WHERE
          /* %JoinFKPK(inserted,Vozilo) */
          inserted.IdV = Vozilo.IdV
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Zahtev because Vozilo does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Zahtev on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Zahtev"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="IdK" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(IdK)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.IdK = Korisnik.IdK
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Zahtev because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


create trigger TR_TransportOffer_DeleteOffers
	on Ponuda
	for update
as
begin
	declare @idP int
	declare @MyCursor Cursor

	set @MyCursor = cursor for
	select IdP
	from inserted

	open @MyCursor

	fetch next from @MyCursor
	into @idP

	while @@FETCH_STATUS = 0
	begin
		delete from Ponuda
		where IdP = @idP

		fetch next from @MyCursor
		into @idP
	end

	close @MyCursor
	deallocate @MyCursor
end

go

create procedure spOdobriZahtev
	@korIme varchar(100),
	@odobren int output
as
begin
	declare @idK1 int
	declare @idK2 int
	declare @idK int
	declare @idV int

	set @idK1 = -1
	set @idK2 = -1
	set @idK = -1
	set @idV = -1

	select @idK1 = k.IdK
	from Kurir k join Korisnik ko on k.IdK=ko.IdK
	where KorIme = @korIme

	if (@idK1 != -1)
	begin
		set @odobren = 0
	end
	else
	begin
		select @idK2 = IdK
		from Korisnik
		where KorIme = @korIme

		if (@idK2 = -1)
			set @odobren = 0
		else
		begin
			select @idV = z.IdV, @idK = z.IdK
			from Zahtev z join Korisnik k on k.IdK=z.IdK
			where KorIme = @korIme
			if (@idV = -1)
				set @odobren = 0
			else
			begin
				delete from Zahtev where IdK = @idK and IdV = @idV
				insert into Kurir (IdK, IdV, BrojIsporPaketa, Profit, Status) values(@idK, @idV, 0, 0, 0)
				set @odobren = 1
			end
		end
	end
end

go