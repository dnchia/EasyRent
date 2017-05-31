CREATE TABLE photos (
  id            UUID             NOT NULL,
  upload_date   DATE             NOT NULL,
  filename      VARCHAR(100)     NOT NULL,
  property_id   UUID             ,
  user_id       UUID             ,

  CONSTRAINT pk_photos PRIMARY KEY (id),

  CONSTRAINT fk_property_id FOREIGN KEY (property_id)
    REFERENCES properties(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,

  CONSTRAINT fk_user_id FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);