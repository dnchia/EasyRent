CREATE TABLE booking_proposals (
  id                  UUID              NOT NULL,
  property_id         UUID              NOT NULL,
  tenant_id           UUID              NOT NULL,
  start_date          DATE              NOT NULL,
  end_date            DATE              NOT NULL,
  status              VARCHAR(10)       NOT NULL,
  payment_reference   VARCHAR(100)      NOT NULL,
  total_amount        FLOAT(10)         NOT NULL,
  number_of_tenants   NUMERIC(2, 0)     NOT NULL,
  date_of_creation    DATE              NOT NULL,
  date_of_acceptation DATE              ,

  CONSTRAINT pk_booking_proposals PRIMARY KEY (id),

  CONSTRAINT fk_bp_property_id FOREIGN KEY (property_id)
    REFERENCES properties(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT fk_bp_tenant_id FOREIGN KEY (tenant_id)
    REFERENCES users(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT ir_bp_status CHECK (status LIKE 'accepted' OR status LIKE 'rejected' OR status LIKE 'pendent')
);