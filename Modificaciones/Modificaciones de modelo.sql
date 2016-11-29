use LeoBikes
go

CREATE TABLE LB_Avisos
(
	ID Char(5) CONSTRAINT PK_Avisos PRIMARY KEY,
	Fecha datetime default current_timestamp,
	Stock_min TinyInt,
	Stock_actual SmallInt,
	CONSTRAINT FK_Productos_Avisos foreign key (ID) references LB_Productos(Codigo)
	--CONSTRAINT FK_Productos_StockActual FOREIGN KEY (Stock_actual) REFERENCES LB_Productos (Stock_Actual),
	--CONSTRAINT FK_Productos_StockMinimo FOREIGN KEY (Stock_min) REFERENCES LB_Productos (Stock_Minimo)
)

ALTER TABLE LB_Productos ADD CONSTRAINT DF_StockActual DEFAULT  0 FOR Stock_Actual
ALTER TABLE LB_Productos ADD CONSTRAINT DF_StockMinimo DEFAULT  0 FOR Stock_Minimo

