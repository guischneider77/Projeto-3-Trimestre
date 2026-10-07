drop database if exists pizzaria_entrega;

create database pizzaria_entrega;

use pizzaria_entrega;

create table clientes (
    id_cliente int primary key auto_increment,
    nome varchar(100) not null,
    telefone varchar(20) not null unique,
    cpf varchar(14) not null unique,
    email varchar(100) not null unique
);

create table enderecos (
    id_endereco int primary key auto_increment,
    id_cliente int not null,
    rua varchar(100) not null,
    numero varchar(10) not null,
    bairro varchar(50) not null,
    cidade varchar(50) not null,
    cep varchar(9) not null,
    ativo char(1) default 'S',
    foreign key (id_cliente)
        references clientes(id_cliente)
        on delete cascade
        on update cascade
);

create table entregadores (
    id_entregador int primary key auto_increment,
    nome varchar(100) not null,
    telefone varchar(20) not null unique,
    cpf varchar(14) not null unique
);

create table motos (
    id_moto int primary key auto_increment,
    id_entregador int not null,
    placa varchar(8) not null unique,
    chassi varchar(17) not null unique,
    modelo varchar(50) not null,
    ano int not null,
    foreign key (id_entregador)
        references entregadores(id_entregador)
        on delete cascade
        on update cascade
);

create table pizzas (
    id_pizza int primary key auto_increment,
    sabor varchar(50) not null,
    preco decimal(10,2) not null check (preco > 0),
    quantidade_pedacos int not null check (quantidade_pedacos > 0)
);

create table pedidos (
    id_pedido int primary key auto_increment,
    id_cliente int not null,
    id_endereco int not null,
    id_entregador int,
    data_pedido datetime default current_timestamp,
    valor decimal(10,2) not null check (valor > 0),
    status_pedido varchar(20) default 'Pendente',
    foreign key (id_cliente)
        references clientes(id_cliente)
        on delete cascade
        on update cascade,
    foreign key (id_endereco)
        references enderecos(id_endereco)
        on delete cascade
        on update cascade,
    foreign key (id_entregador)
        references entregadores(id_entregador)
        on delete cascade
        on update cascade
);

create table itens_pedido (
    id_item int primary key auto_increment,
    id_pedido int not null,
    id_pizza int not null,
    quantidade_pizzas int not null check (quantidade_pizzas > 0),
    foreign key (id_pedido)
        references pedidos(id_pedido)
        on delete cascade
        on update cascade,
    foreign key (id_pizza)
        references pizzas(id_pizza)
        on delete cascade
        on update cascade
);

create table caixa (
    id_caixa int primary key auto_increment,
    descricao varchar(150) not null,
    valor decimal(10,2) not null check (valor > 0),
    tipo_pagamento varchar(20) not null
);

insert into clientes
(nome, telefone, cpf, email)
values
('Joao Silva','41999990001','123.456.789-01','joao@gmail.com'),
('Maria Souza','41999990002','123.456.789-02','maria@gmail.com'),
('Pedro Santos','41999990003','123.456.789-03','pedro@gmail.com'),
('Ana Lima','41999990004','123.456.789-04','ana@gmail.com'),
('Carlos Oliveira','41999990005','123.456.789-05','carlos@gmail.com'),
('Fernanda Alves','41999990006','123.456.789-06','fernanda@gmail.com'),
('Lucas Pereira','41999990007','123.456.789-07','lucas@gmail.com'),
('Beatriz Costa','41999990008','123.456.789-08','bia@gmail.com'),
('Rafael Martins','41999990009','123.456.789-09','rafael@gmail.com'),
('Juliana Rocha','41999990010','123.456.789-10','juliana@gmail.com');

insert into enderecos
(id_cliente, rua, numero, bairro, cidade, cep, ativo)
values
(1,'Rua A','10','Centro','Foz do Iguacu','85850-000','S'),
(2,'Rua B','20','Vila Nova','Foz do Iguacu','85851-000','S'),
(3,'Rua C','30','Jardim','Foz do Iguacu','85852-000','S'),
(4,'Rua D','40','Centro','Foz do Iguacu','85853-000','S'),
(5,'Rua E','50','Alto','Foz do Iguacu','85854-000','S'),
(6,'Rua F','60','Centro','Foz do Iguacu','85855-000','S'),
(7,'Rua G','70','Vila','Foz do Iguacu','85856-000','S'),
(8,'Rua H','80','Jardim','Foz do Iguacu','85857-000','S'),
(9,'Rua I','90','Centro','Foz do Iguacu','85858-000','S'),
(10,'Rua J','100','Novo','Foz do Iguacu','85859-000','S');

insert into entregadores
(nome, telefone, cpf)
values
('Marcos','41988880001','987.654.321-01'),
('Renan','41988880002','987.654.321-02'),
('Diego','41988880003','987.654.321-03'),
('Bruno','41988880004','987.654.321-04'),
('Felipe','41988880005','987.654.321-05');

insert into motos
(id_entregador, placa, chassi, modelo, ano)
values
(1,'ABC1D23','9C2KC0810PR123456','Honda CG 160',2024),
(2,'DEF4E56','9C2KC0810PR234567','Honda CG 160',2023),
(3,'GHI7J89','9C2KC0810PR345678','Yamaha Factor 150',2024),
(4,'KLM1N23','9C2KC0810PR456789','Honda CG 160',2022),
(5,'OPQ4R56','9C2KC0810PR567890','Yamaha Factor 150',2023);

insert into pizzas
(sabor, preco, quantidade_pedacos)
values
('Calabresa',35,8),
('Frango com Catupiry',42,8),
('Mussarela',30,6),
('Portuguesa',40,8),
('Chocolate',38,6),
('Bacon',45,8),
('Quatro Queijos',43,8),
('Napolitana',32,6),
('Pepperoni',44,8),
('Vegetariana',36,8);

insert into pedidos
(id_cliente, id_endereco, id_entregador, valor, status_pedido)
values
(1,1,1,35,'Entregue'),
(2,2,2,42,'Entregue'),
(3,3,3,60,'Pendente'),
(4,4,4,40,'Cancelado'),
(5,5,5,38,'Entregue'),
(6,6,1,45,'Pendente'),
(7,7,2,86,'Cancelado'),
(8,8,3,32,'Entregue'),
(9,9,4,44,'Pendente'),
(10,10,5,72,'Entregue');

insert into itens_pedido
(id_pedido, id_pizza, quantidade_pizzas)
values
(1,1,1),
(2,2,1),
(3,3,2),
(4,4,1),
(5,5,1),
(6,6,1),
(7,7,2),
(8,8,1),
(9,9,1),
(10,10,2);

insert into caixa
(descricao, valor, tipo_pagamento)
values
('Pagamento pedido 1',35,'Pix'),
('Pagamento pedido 2',42,'Cartao'),
('Pagamento pedido 3',60,'Dinheiro'),
('Pagamento pedido 4',40,'Pix'),
('Pagamento pedido 5',38,'Cartao'),
('Pagamento pedido 6',45,'Pix'),
('Pagamento pedido 7',86,'Dinheiro'),
('Pagamento pedido 8',32,'Cartao'),
('Pagamento pedido 9',44,'Pix'),
('Pagamento pedido 10',72,'Dinheiro');

delimiter //

create trigger verificar_cliente_antes_cadastro
before insert on clientes
for each row
begin
    if trim(new.nome) = '' then
        signal sqlstate '45000'
        set message_text = 'O nome do cliente nao pode ficar vazio';
    end if;
end //

create trigger verificar_pizza_antes_cadastro
before insert on pizzas
for each row
begin
    if new.preco <= 0 then
        signal sqlstate '45000'
        set message_text = 'O preco da pizza deve ser maior que zero';
    end if;

    if new.quantidade_pedacos <= 0 then
        signal sqlstate '45000'
        set message_text = 'A quantidade de pedacos deve ser maior que zero';
    end if;
end //

create trigger verificar_pedido_antes_atualizacao
before update on pedidos
for each row
begin
    if new.valor <= 0 then
        signal sqlstate '45000'
        set message_text = 'O valor do pedido deve ser maior que zero';
    end if;

    if new.status_pedido not in ('Pendente','Entregue','Cancelado') then
        signal sqlstate '45000'
        set message_text = 'Status do pedido invalido';
    end if;
end //

create trigger registrar_exclusao_pedido
after delete on pedidos
for each row
begin
    insert into caixa
    (descricao, valor, tipo_pagamento)
    values
    (concat('Estorno pedido ', old.id_pedido), old.valor, 'Estorno');
end //

delimiter ;

delimiter //

create procedure cadastrar_cliente(
    nome_cliente varchar(100),
    telefone_cliente varchar(20),
    cpf_cliente varchar(14),
    email_cliente varchar(100)
)
begin
    insert into clientes
    (nome, telefone, cpf, email)
    values
    (nome_cliente, telefone_cliente, cpf_cliente, email_cliente);
end //

create procedure listar_pizzas()
begin
    select
        id_pizza,
        sabor,
        preco,
        quantidade_pedacos
    from pizzas;
end //

create procedure pedidos_cliente(cliente int)
begin
    select
        id_pedido,
        id_cliente,
        id_endereco,
        id_entregador,
        data_pedido,
        valor,
        status_pedido
    from pedidos
    where id_cliente = cliente;
end //

create procedure cadastrar_pizza(
    nome_pizza varchar(50),
    valor_pizza decimal(10,2)
)
begin
    insert into pizzas
    (sabor, preco, quantidade_pedacos)
    values
    (nome_pizza, valor_pizza, 8);
end //

create procedure atualizar_status(
    pedido int,
    novo_status varchar(20)
)
begin
    update pedidos
    set status_pedido = novo_status
    where id_pedido = pedido;
end //

delimiter ;

select
    clientes.nome,
    clientes.cpf,
    pizzas.sabor,
    pizzas.preco * itens_pedido.quantidade_pizzas as valor,
    pizzas.quantidade_pedacos * itens_pedido.quantidade_pizzas as quantidade_pedacos,
    itens_pedido.quantidade_pizzas,
    pedidos.status_pedido
from pedidos
inner join clientes
    on pedidos.id_cliente = clientes.id_cliente
inner join itens_pedido
    on pedidos.id_pedido = itens_pedido.id_pedido
inner join pizzas
    on itens_pedido.id_pizza = pizzas.id_pizza;

select
    entregadores.nome,
    entregadores.cpf,
    pedidos.id_pedido,
    pedidos.status_pedido
from entregadores
inner join pedidos
    on entregadores.id_entregador = pedidos.id_entregador;

select
    clientes.nome,
    enderecos.cidade,
    enderecos.bairro,
    enderecos.cep
from clientes
inner join enderecos
    on clientes.id_cliente = enderecos.id_cliente;

select
    clientes.nome,
    clientes.cpf,
    pizzas.sabor,
    entregadores.nome as entregador,
    entregadores.cpf as cpf_entregador,
    pedidos.status_pedido
from pedidos
inner join clientes
    on pedidos.id_cliente = clientes.id_cliente
inner join itens_pedido
    on pedidos.id_pedido = itens_pedido.id_pedido
inner join pizzas
    on itens_pedido.id_pizza = pizzas.id_pizza
inner join entregadores
    on pedidos.id_entregador = entregadores.id_entregador;

select
    entregadores.nome,
    entregadores.cpf,
    motos.modelo,
    motos.placa,
    motos.ano
from entregadores
inner join motos
    on entregadores.id_entregador = motos.id_entregador;

select
    clientes.nome,
    count(pedidos.id_pedido) as quantidade_pedidos
from clientes
left join pedidos
    on clientes.id_cliente = pedidos.id_cliente
group by clientes.id_cliente, clientes.nome;

select
    pizzas.sabor,
    itens_pedido.quantidade_pizzas,
    itens_pedido.id_pedido
from pizzas
right join itens_pedido
    on pizzas.id_pizza = itens_pedido.id_pizza;

select
    pedidos.id_pedido,
    clientes.nome,
    clientes.cpf,
    pedidos.valor,
    pedidos.status_pedido
from pedidos
left join clientes
    on pedidos.id_cliente = clientes.id_cliente;

call listar_pizzas();

call pedidos_cliente(1);