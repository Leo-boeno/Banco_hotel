-- Índice na coluna CNPJ da tabela Hotel
CREATE INDEX idx_hotel_cnpj ON trabalho_hotel.Hotel(CNPJ);

-- Índice na coluna fk_Hotel_CNPJ da tabela Quarto
CREATE INDEX idx_quarto_fk_hotel_cnpj ON trabalho_hotel.Quarto(fk_Hotel_CNPJ);

-- Índice na coluna Disponibilidade da tabela Quarto
CREATE INDEX idx_quarto_disponibilidade ON trabalho_hotel.Quarto(Disponibilidade);

-- Índice na coluna ID da tabela Quarto
CREATE INDEX idx_quarto_id ON trabalho_hotel.Quarto(ID);

-- Índice na coluna fk_Quarto_ID da tabela Reservado
CREATE INDEX idx_reservado_fk_quarto_id ON trabalho_hotel.Reservado(fk_Quarto_ID);

-- Índice na coluna fk_Reserva_Numero_de_reserva da tabela Reservado
CREATE INDEX idx_reservado_fk_reserva_numero_de_reserva ON trabalho_hotel.Reservado(fk_Reserva_Numero_de_reserva);

-- Índice na coluna Numero_de_reserva da tabela Reserva
CREATE INDEX idx_reserva_numero_de_reserva ON trabalho_hotel.Reserva(Numero_de_reserva);

-- Índice na coluna fk_Reserva_Numero_de_reserva da tabela Faz
CREATE INDEX idx_faz_fk_reserva_numero_de_reserva ON trabalho_hotel.Faz(fk_Reserva_Numero_de_reserva);
