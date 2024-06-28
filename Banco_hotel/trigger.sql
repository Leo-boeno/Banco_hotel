
-- Trigger para verificar 
create or replace function after_reserva_insert()
returns trigger as $$
begin
    insert into trabalho_hotel.Reservado (fk_Reserva_Numero_de_reserva, fk_Quarto_ID)
    select new.Numero_de_reserva, q.ID
    from trabalho_hotel.Quarto q
    inner join trabalho_hotel.Faz f on q.fk_Hospede_Documento = f.fk_Hospede_Documento
    where q.Disponibilidade = 'false'
      and f.fk_Reserva_Numero_de_reserva = new.Numero_de_reserva;
    return new;
end;
$$ language plpgsql;


create trigger after_reserva_insert
after insert on trabalho_hotel.Reserva
for each row
execute function after_reserva_insert();


-- Trigger para atualizar a disponibilidade do quarto
CREATE OR REPLACE FUNCTION atualizar_disponibilidade_quarto()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE trabalho_hotel.Quarto
    SET Disponibilidade = FALSE
    WHERE ID = NEW.fk_Quarto_ID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_disponibilidade_quarto
AFTER INSERT ON trabalho_hotel.Reservado
FOR EACH ROW
EXECUTE FUNCTION atualizar_disponibilidade_quarto();


-- Trigger para verificar a data de check-out

CREATE OR REPLACE FUNCTION verificar_data_check_out()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Data_check_out <= NEW.Data_check_in THEN
        RAISE EXCEPTION 'Data de check-out deve ser posterior à data de check-in';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_data_check_out
BEFORE INSERT OR UPDATE ON trabalho_hotel.Reserva
FOR EACH ROW
EXECUTE FUNCTION verificar_data_check_out();
