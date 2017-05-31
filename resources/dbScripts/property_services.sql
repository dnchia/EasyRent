CREATE TABLE property_services (
  id               UUID   NOT NULL,
  property_id      UUID   NOT NULL,
  service_id       UUID   NOT NULL,

  CONSTRAINT pk_property_services PRIMARY KEY (id),

  CONSTRAINT ak_property_services UNIQUE (property_id, service_id),

  CONSTRAINT fk_ps_property_id FOREIGN KEY (property_id)
    REFERENCES properties(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT fk_ps_service_id FOREIGN KEY (service_id)
    REFERENCES services(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);