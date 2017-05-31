CREATE TABLE availability_periods (
  id            UUID          NOT NULL,
  property_id   UUID          NOT NULL,
  start_date    DATE          NOT NULL,
  end_date      DATE          ,

  CONSTRAINT pk_availability_periods PRIMARY KEY (id),

  CONSTRAINT ak_availability_periods UNIQUE (property_id),

  CONSTRAINT fk_ap_property_id FOREIGN KEY (property_id)
    REFERENCES properties(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT ir_aop_dates CHECK (availability_periods.start_date < availability_periods.end_date)
);