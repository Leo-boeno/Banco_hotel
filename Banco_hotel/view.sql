create view Hotel_Ocupacao as
select h.Nome, h.CNPJ,
       count(q.ID) as Total_Quartos,
       sum(case when q.Disponibilidade = 'false' then 1 else 0 end) as Quartos_Ocupados,
       (sum(case when q.Disponibilidade = 'false' then 1 else 0 end) * 100.0 / count(q.ID)) as Porcentagem_Ocupacao
from trabalho_hotel.Hotel h
inner join trabalho_hotel.Quarto q on h.CNPJ = q.fk_Hotel_CNPJ
group by h.Nome, h.CNPJ
order by Porcentagem_Ocupacao desc;
