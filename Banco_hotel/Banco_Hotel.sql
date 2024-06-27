create schema trabalho_hotel;

CREATE TABLE trabalho_hotel.Hospede (
    Nome VARCHAR(255)not null,
    Endereco VARCHAR(255)not null,
    Documento bigint PRIMARY KEY
);

CREATE TABLE trabalho_hotel.Reserva (
    Numero_de_reserva serial PRIMARY KEY,
    Data_check_in DATE,
    Data_check_out DATE,
    Valor_da_reserva NUMERIC
);

CREATE TABLE trabalho_hotel.Quarto (
    Preco numeric not null,
    Disponibilidade BOOLEAN not null,
    ID serial PRIMARY KEY,
    fk_Hospede_Documento bigint references trabalho_hotel.Hospede(Documento),
    fk_Hotel_CNPJ bigint references trabalho_hotel.Hotel(CNPJ)
);

CREATE TABLE trabalho_hotel.Hotel (
    Nome VARCHAR(255)not null,
    Endereco VARCHAR(255)not null,
    Telefon bigint not null,
    Classificacao float,
    Preco_Medio_por_pessoa numeric(10,2)not null,
    CNPJ bigint PRIMARY KEY
);

CREATE TABLE trabalho_hotel.Funcionario (
    Nome VARCHAR(255)not null,
    Cargo VARCHAR(100)not null,
    CPF bigint PRIMARY KEY
);

CREATE TABLE trabalho_hotel.Trabalha (
	fk_Hotel_CNPJ bigint, 
	fk_Funcionario_CPF bigint, 
    primary key (fk_Hotel_CNPJ,fk_Funcionario_CPF), 
    foreign key (fk_Hotel_CNPJ) references trabalho_hotel.Hotel (CNPJ),
    foreign key (fk_Funcionario_CPF) references trabalho_hotel.Funcionario (CPF)
);

CREATE TABLE trabalho_hotel.Faz (
    fk_Reserva_Numero_de_reserva INTEGER,
    fk_Hospede_Documento bigint, 
    primary key (fk_Reserva_Numero_de_reserva, fk_Hospede_Documento),
    foreign key (fk_Reserva_Numero_de_reserva) references trabalho_hotel.Reserva(Numero_de_reserva),
    foreign key (fk_Hospede_Documento) references trabalho_hotel.Hospede(Documento)
);

CREATE TABLE trabalho_hotel.Reservado (
    fk_Reserva_Numero_de_reserva INTEGER,
    fk_Quarto_ID INTEGER,
    primary key (fk_Reserva_Numero_de_reserva, fk_Quarto_ID),
    foreign key (fk_Reserva_Numero_de_reserva) references trabalho_hotel.Reserva(Numero_de_reserva),
    foreign key (fk_Quarto_ID) references trabalho_hotel.Quarto(ID)
);