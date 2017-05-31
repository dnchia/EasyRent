CREATE TABLE invoices (
  id               UUID              NOT NULL,
  invoice_number   SERIAL            NOT NULL,
  proposal_id      UUID              NOT NULL,
  actual_vat       FLOAT(2)          NOT NULL,
  address          VARCHAR(50)       NOT NULL,
  invoice_date     DATE              NOT NULL,

  CONSTRAINT pk_invoices PRIMARY KEY (id),

  CONSTRAINT ak_invoices UNIQUE (invoice_number),

  CONSTRAINT fk_i_tracking_number FOREIGN KEY (proposal_id)
    REFERENCES booking_proposals(id)
    ON UPDATE CASCADE
    ON DELETE SET NULL


);