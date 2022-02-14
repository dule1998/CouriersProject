package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.VehicleOperations;

public class jd170351_VehicleOperations implements VehicleOperations {

	public jd170351_VehicleOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean changeConsumption(String arg0, BigDecimal arg1) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement ps = conn.prepareStatement(
				"update Vozilo set Potrosnja=? where RegBr=?")) {
			ps.setBigDecimal(1, arg1);
			ps.setString(2, arg0);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Ubacen je korisnik: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return false;
	}

	@Override
	public boolean changeFuelType(String arg0, int arg1) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement ps = conn.prepareStatement(
				"update Vozilo set TipGoriva=? where RegBr=?")) {
			ps.setInt(1, arg1);
			ps.setString(2, arg0);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Ubacen je korisnik: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return false;
	}

	@Override
	public int deleteVehicles(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		if (arg0.length == 0) {
			return 0;
		}
		String query = "delete from Vozilo where RegBr=?";
		for (int i = 0; i < arg0.length - 1; i++) {
			query += " or RegBr=?";
		}
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			for (int i = 0; i < arg0.length; i++) {
				ps.setString(i + 1, arg0[i]);
			}
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res;
	}

	@Override
	public List<String> getAllVehichles() {
		Connection conn = DB.getInstance().getConnection();
		List<String> vozila = new ArrayList<String>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Vozilo");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				vozila.add(rs.getString(2));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return vozila;
	}

	@Override
	public boolean insertVehicle(String arg0, int arg1, BigDecimal arg2) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Vozilo where RegBr=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					// System.out.println("Vec postoji vozilo sa ovim registarskim brojem");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement(
				"insert into Vozilo (RegBr, TipGoriva, Potrosnja) values(?, ?, ?)")) {
			ps.setString(1, arg0);
			ps.setInt(2, arg1);
			ps.setBigDecimal(3, arg2);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Ubacen je korisnik: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		return false;
	}

}
