create procedure spOdobriZahtev
	@korIme varchar(100),
	@odobren int output
as
begin
	declare @idK1 int
	declare @idK2 int
	declare @idK int
	declare @idV int

	set @idK1 = -1
	set @idK2 = -1
	set @idK = -1
	set @idV = -1

	select @idK1 = k.IdK
	from Kurir k join Korisnik ko on k.IdK=ko.IdK
	where KorIme = @korIme

	if (@idK1 != -1)
	begin
		set @odobren = 0
	end
	else
	begin
		select @idK2 = IdK
		from Korisnik
		where KorIme = @korIme

		if (@idK2 = -1)
			set @odobren = 0
		else
		begin
			select @idV = z.IdV, @idK = z.IdK
			from Zahtev z join Korisnik k on k.IdK=z.IdK
			where KorIme = @korIme
			if (@idV = -1)
				set @odobren = 0
			else
			begin
				delete from Zahtev where IdK = @idK and IdV = @idV
				insert into Kurir (IdK, IdV, BrojIsporPaketa, Profit, Status) values(@idK, @idV, 0, 0, 0)
				set @odobren = 1
			end
		end
	end
end