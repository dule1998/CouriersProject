package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.CityOperations;

public class jd170351_CityOperations implements CityOperations {

	public jd170351_CityOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int deleteCity(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		if (arg0.length == 0) {
			return 0;
		}
		String query = "delete from Grad where Naziv=?";
		for (int i = 0; i < arg0.length - 1; i++) {
			query += " or Naziv=?";
		}
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			for (int i = 0; i < arg0.length; i++) {
				ps.setString(i + 1, arg0[i]);
			}
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res;
	}

	@Override
	public boolean deleteCity(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("delete from Grad where IdG=?");) {
			ps.setInt(1, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res > 0 ? true : false;
	}

	@Override
	public List<Integer> getAllCities() {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> gradovi = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Grad"); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				gradovi.add(rs.getInt(1));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return gradovi;
	}

	@Override
	public int insertCity(String arg0, String arg1) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Grad where Naziv=? or PostBr=?");) {
			stmt.setString(1, arg0);
			stmt.setString(2, arg1);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					// System.out.println("Vec postoji grad sa ovim nazivom ili postanskim brojem");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement("insert into Grad (Naziv, PostBr) values(?, ?)")) {
			ps.setString(1, arg0);
			ps.setString(2, arg1);
			ps.executeUpdate();
			// System.out.println("Ubacen je grad: " + string + ", " + string1);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt1 = conn.prepareStatement("select * from Grad where Naziv=? and PostBr=?")) {
			stmt1.setString(1, arg0);
			stmt1.setString(2, arg1);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (rs1.next()) {
					return rs1.getInt(1);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return -1;
	}

}
