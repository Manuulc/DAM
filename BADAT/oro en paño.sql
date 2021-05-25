select * from Clasificacion
select * from Equipos
select * from Partidos

insert into Clasificacion (IDEquipo, NombreEquipo) select ID, Nombre from Equipos

--Para goles a Favor
select SUM(GolesLocal) as golesLocal from Partidos where ELocal in ('AJAX')
select SUM(GolesVisitante) as golesVisitantes from Partidos where EVisitante in ('AJAX')
update Clasificacion set GolesFavor=((select SUM(GolesLocal) as golesLocal from Partidos where ELocal in ('AJAX'))+(select SUM(GolesVisitante) as golesVisitantes from Partidos where EVisitante in ('AJAX'))) where IDEquipo='AJAX'

--Para goles en Contra
select SUM(GolesLocal) as golesLocal from Partidos where EVisitante in ('AJAX')
select SUM(GolesVisitante) as golesVisitantes from Partidos where ELocal in ('AJAX')
update Clasificacion set GolesContra=((select SUM(GolesLocal) as golesLocal from Partidos where EVisitante in ('AJAX'))+(select SUM(GolesVisitante) as golesVisitantes from Partidos where ELocal in ('AJAX'))) where IDEquipo='AJAX'


--Para partidos Jugados
select COUNT(Finalizado) from Partidos where ELocal in ('AJAX') or EVisitante in ('AJAX')
update Clasificacion set PartidosJugados=(select COUNT(Finalizado) from Partidos where ELocal in ('AJAX') or EVisitante in ('AJAX')) where IDEquipo='AJAX'


--Para partidos Ganados









begin transaction

rollback

delete Clasificacion where IDEquipo is not null