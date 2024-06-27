-- Calculando a receita de um hotel
CREATE OR REPLACE PROCEDURE calcular_receita_total_hotel(
    IN hotel_cnpj BIGINT,
    IN data_inicio DATE,
    IN data_fim DATE,
    OUT receita_total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(r.Valor_da_reserva)
    INTO receita_total
    FROM trabalho_hotel.Reserva r
    JOIN trabalho_hotel.Faz f ON r.Numero_de_reserva = f.fk_Reserva_Numero_de_reserva
    JOIN trabalho_hotel.Hospede h ON f.fk_Hospede_Documento = h.Documento
    JOIN trabalho_hotel.Quarto q ON q.fk_Hospede_Documento = h.Documento
    WHERE q.fk_Hotel_CNPJ = hotel_cnpj
      AND r.Data_check_in >= data_inicio
      AND r.Data_check_out <= data_fim;
END;
$$;

