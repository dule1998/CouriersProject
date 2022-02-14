create trigger TR_TransportOffer_DeleteOffers
	on Ponuda
	for update
as
begin
	declare @idP int
	declare @MyCursor Cursor

	set @MyCursor = cursor for
	select IdP
	from inserted

	open @MyCursor

	fetch next from @MyCursor
	into @idP

	while @@FETCH_STATUS = 0
	begin
		delete from Ponuda
		where IdP = @idP

		fetch next from @MyCursor
		into @idP
	end

	close @MyCursor
	deallocate @MyCursor
end