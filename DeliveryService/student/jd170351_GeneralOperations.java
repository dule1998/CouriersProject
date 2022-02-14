package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.GeneralOperations;

public class jd170351_GeneralOperations implements GeneralOperations {

	public jd170351_GeneralOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void eraseAll() {
		Connection conn = DB.getInstance().getConnection();
		String query = "delete from Ponuda;delete Voznja;delete from Paket;delete from Prevoz;delete from Opstina;delete from Grad;"
				+ "delete from Zahtev;" + "delete from Administrator;delete from Kurir;"
				+ "delete from Korisnik;delete from Vozilo;";
		try (PreparedStatement ps = conn.prepareStatement(query)) {
			ps.execute();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_GeneralOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

}
