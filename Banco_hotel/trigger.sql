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

