CREATE TABLE users (
  id                  UUID          NOT NULL,
  username            VARCHAR(20)   NOT NULL,
  national_document   VARCHAR(9)    NOT NULL,
  role                VARCHAR(20)   NOT NULL,
  password            VARCHAR(50)   NOT NULL,
  name                VARCHAR(50)   NOT NULL,
  surnames            VARCHAR(50)   NOT NULL,
  email               VARCHAR(50)   NOT NULL,
  phone_number        VARCHAR(20)   ,
  country             VARCHAR(20)   ,
  post_address        VARCHAR(100)   ,
  post_code           NUMERIC(10, 0) ,
  sign_up_date        DATE          NOT NULL,
  active              BOOLEAN       NOT NULL,
  deactivated_since   DATE          ,

  CONSTRAINT pk_users PRIMARY KEY (id),
  CONSTRAINT ak_u_username UNIQUE (username),
  CONSTRAINT ak_u_national_document UNIQUE (national_document)
);