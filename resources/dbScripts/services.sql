CREATE TABLE services (
  id                UUID            NOT NULL,
  service_value     VARCHAR(50)     NOT NULL,
  service_name      VARCHAR(50)     NOT NULL,
  user_id           UUID            ,
  active            BOOLEAN         NOT NULL,
  creation_date     DATE            NOT NULL,
  service_proposals INTEGER         NOT NULL,
  active_since      DATE            ,

  CONSTRAINT pk_services PRIMARY KEY (id),

  CONSTRAINT ak_services UNIQUE (service_value),

  CONSTRAINT fk_s_username FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);