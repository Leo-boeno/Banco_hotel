-- Quartos disponiveis em cada hotel
select h.nome, count(q.id) from trabalho_hotel.hotel h
inner join trabalho_hotel.quarto q on h.cnpj = q.fk_hotel_cnpj
where q.disponibilidade = true
group by h.cnpj;

-- Quartos reservados
select q.ID, q.Preco, q.fk_Hotel_CNPJ, r.Numero_de_reserva, r.Data_check_in, r.Data_check_out, r.Valor_da_reserva, f.fk_Hospede_Documento
from trabalho_hotel.Quarto q
inner join trabalho_hotel.Reservado res on q.ID = res.fk_Quarto_ID
inner join trabalho_hotel.Reserva r on res.fk_Reserva_Numero_de_reserva = r.Numero_de_reserva
inner join trabalho_hotel.Faz f on r.Numero_de_reserva = f.fk_Reserva_Numero_de_reserva
where q.Disponibilidade = 'false';

-- Ocupação de quartos por hotel
select h.Nome, h.CNPJ,
       count(q.ID) AS Total_Quartos,
       sum(case when q.Disponibilidade = 'false' then 1 else 0 end) as Quartos_Ocupados,
       (sum(case when q.Disponibilidade = 'false' then 1 else 0 end) * 100.0 / count(q.ID)) as Porcentagem_Ocupacao
from trabalho_hotel.Hotel h
inner join trabalho_hotel.Quarto q ON h.CNPJ = q.fk_Hotel_CNPJ
group by h.Nome, h.CNPJ
order by Porcentagem_Ocupacao desc;

--  Receita total por hotel
select h.Nome, h.CNPJ, sum(r.Valor_da_reserva) as Receita_Total
from trabalho_hotel.Hotel h
inner join trabalho_hotel.Quarto q on h.CNPJ = q.fk_Hotel_CNPJ
inner join trabalho_hotel.Reservado res on q.ID = res.fk_Quarto_ID
inner join trabalho_hotel.Reserva r on res.fk_Reserva_Numero_de_reserva = r.Numero_de_reserva
group by h.Nome, h.CNPJ
order by Receita_Total desc;

--

select * from hotel_ocupacao ho;

