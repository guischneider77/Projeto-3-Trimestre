create database pizzaria_entrega;

use pizzaria_entrega;

create table clientes (
    id_cliente int primary key auto_increment,
    nome varchar(100) not null,
    telefone varchar(20) not null unique,
    email varchar(100) not null unique
);

create table enderecos (
    id_endereco int primary key auto_increment,
    id_cliente int not null,
    rua varchar(100) not null,
    numero varchar(10) not null,
    bairro varchar(50) not null,
    cep varchar(9) not null,
    ativo char(1) default 'S',

    foreign key(id_cliente)
    references clientes(id_cliente)
);

create table entregadores (
    id_entregador int primary key auto_increment,
    nome varchar(100) not null,
    telefone varchar(20) not null unique
);

create table pizzas (
    id_pizza int primary key auto_increment,
    sabor varchar(50) not null,
    preco decimal(10,2) not null check(preco > 0),
    quantidade_pedacos int not null check(quantidade_pedacos > 0)
);

create table pedidos (
    id_pedido int primary key auto_increment,
    id_cliente int not null,
    id_endereco int not null,
    id_entregador int,
    data_pedido datetime default current_timestamp,
    valor decimal(10,2) not null check(valor > 0),
    status_pedido varchar(20) default 'Pendente',

    foreign key(id_cliente)
    references clientes(id_cliente),

    foreign key(id_endereco)
    references enderecos(id_endereco),

    foreign key(id_entregador)
    references entregadores(id_entregador)
);

create table itens_pedido (
    id_item int primary key auto_increment,
    id_pedido int not null,
    id_pizza int not null,
    quantidade_pizzas int not null check(quantidade_pizzas > 0),

    foreign key(id_pedido)
    references pedidos(id_pedido),

    foreign key(id_pizza)
    references pizzas(id_pizza)
);

insert into clientes(nome,telefone,email) values
('Joao Silva','41999990001','joao@gmail.com'),
('Maria Souza','41999990002','maria@gmail.com'),
('Pedro Santos','41999990003','pedro@gmail.com'),
('Ana Lima','41999990004','ana@gmail.com'),
('Carlos Oliveira','41999990005','carlos@gmail.com'),
('Fernanda Alves','41999990006','fernanda@gmail.com'),
('Lucas Pereira','41999990007','lucas@gmail.com'),
('Beatriz Costa','41999990008','bia@gmail.com'),
('Rafael Martins','41999990009','rafael@gmail.com'),
('Juliana Rocha','41999990010','juliana@gmail.com');

insert into enderecos(id_cliente,rua,numero,bairro,cep,ativo) values
(1,'Rua A','10','Centro','85850-000','S'),
(2,'Rua B','20','Vila Nova','85851-000','S'),
(3,'Rua C','30','Jardim','85852-000','S'),
(4,'Rua D','40','Centro','85853-000','S'),
(5,'Rua E','50','Alto','85854-000','S'),
(6,'Rua F','60','Centro','85855-000','S'),
(7,'Rua G','70','Vila','85856-000','S'),
(8,'Rua H','80','Jardim','85857-000','S'),
(9,'Rua I','90','Centro','85858-000','S'),
(10,'Rua J','100','Novo','85859-000','S');

insert into entregadores(nome,telefone) values
('Marcos','41988880001'),
('Renan','41988880002'),
('Diego','41988880003'),
('Bruno','41988880004'),
('Felipe','41988880005');

insert into pizzas(sabor,preco,quantidade_pedacos) values
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
(id_cliente,id_endereco,id_entregador,valor,status_pedido)
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
(id_pedido,id_pizza,quantidade_pizzas)
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

select
clientes.nome,
pizzas.sabor,
(pizzas.preco * itens_pedido.quantidade_pizzas) as valor,
(pizzas.quantidade_pedacos * itens_pedido.quantidade_pizzas) as quantidade_pedacos,
itens_pedido.quantidade_pizzas,
pedidos.status_pedido
from pedidos
join clientes
on pedidos.id_cliente = clientes.id_cliente
join itens_pedido
on pedidos.id_pedido = itens_pedido.id_pedido
join pizzas
on itens_pedido.id_pizza = pizzas.id_pizza;

select
entregadores.nome,
pedidos.status_pedido
from entregadores
join pedidos
on entregadores.id_entregador = pedidos.id_entregador;

select
clientes.nome,
enderecos.rua,
enderecos.numero,
enderecos.bairro,
enderecos.cep,
enderecos.ativo
from clientes
join enderecos
on clientes.id_cliente = enderecos.id_cliente;

select
clientes.nome,
pizzas.sabor,
entregadores.nome as entregador,
pedidos.status_pedido
from pedidos
join clientes
on pedidos.id_cliente = clientes.id_cliente
join itens_pedido
on pedidos.id_pedido = itens_pedido.id_pedido
join pizzas
on itens_pedido.id_pizza = pizzas.id_pizza
join entregadores
on pedidos.id_entregador = entregadores.id_entregador;

delimiter //

create procedure cadastrar_cliente(
nome_cliente varchar(100),
telefone_cliente varchar(20),
email_cliente varchar(100)
)
begin
    insert into clientes(nome,telefone,email)
    values(nome_cliente,telefone_cliente,email_cliente);
end //

delimiter ;

delimiter //

create procedure listar_pizzas()
begin
    select * from pizzas;
end //

delimiter ;

delimiter //

create procedure pedidos_cliente(cliente int)
begin
    select *
    from pedidos
    where id_cliente = cliente;
end //

delimiter ;

delimiter //

create procedure cadastrar_pizza(
nome varchar(50),
valor_pizza decimal(10,2)
)
begin
    insert into pizzas(sabor,preco,quantidade_pedacos)
    values(nome,valor_pizza,8);
end //

delimiter ;

delimiter //

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