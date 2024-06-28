
DO $$
DECLARE
    nova_reserva_id INTEGER;
    novo_hospede_documento BIGINT := 12345678901;
    novo_hospede_nome VARCHAR := 'João da Silva';
    novo_hospede_endereco VARCHAR := 'Rua das Flores, 123';
    data_check_in DATE := '2024-07-01';
    data_check_out DATE := '2024-07-10';
    valor_da_reserva NUMERIC := 1200.00;
    quartos_ids INTEGER[] := ARRAY[1, 2, 3];
    reserva_para_excluir INTEGER := 10;
BEGIN

    BEGIN

        INSERT INTO trabalho_hotel.Hospede (Nome, Endereco, Documento)
        VALUES (novo_hospede_nome, novo_hospede_endereco, novo_hospede_documento);

        INSERT INTO trabalho_hotel.Reserva (Data_check_in, Data_check_out, Valor_da_reserva)
        VALUES (data_check_in, data_check_out, valor_da_reserva)
        RETURNING Numero_de_reserva INTO nova_reserva_id;
        INSERT INTO trabalho_hotel.Faz (fk_Reserva_Numero_de_reserva, fk_Hospede_Documento)
        VALUES (nova_reserva_id, novo_hospede_documento);

        FOREACH quarto_id IN ARRAY quartos_ids
        LOOP
            INSERT INTO trabalho_hotel.Reservado (fk_Reserva_Numero_de_reserva, fk_Quarto_ID)
            VALUES (nova_reserva_id, quarto_id);

            UPDATE trabalho_hotel.Quarto
            SET Disponibilidade = FALSE
            WHERE ID = quarto_id;
        END LOOP;

        IF EXISTS (SELECT 1 FROM trabalho_hotel.Reserva WHERE Numero_de_reserva = reserva_para_excluir) THEN
            DELETE FROM trabalho_hotel.Reservado WHERE fk_Reserva_Numero_de_reserva = reserva_para_excluir;
            DELETE FROM trabalho_hotel.Faz WHERE fk_Reserva_Numero_de_reserva = reserva_para_excluir;
            DELETE FROM trabalho_hotel.Reserva WHERE Numero_de_reserva = reserva_para_excluir;
        END IF;

        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            
            ROLLBACK;
            RAISE;
    END;
END;
$$;
