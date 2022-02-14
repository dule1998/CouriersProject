package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.DistrictOperations;

public class jd170351_DistrictOperations implements DistrictOperations {

	public jd170351_DistrictOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int deleteAllDistrictsFromCity(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		int idG = -1;
		try (PreparedStatement stmt = conn.prepareStatement("select * from Grad where Naziv=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (!rs.next()) {
					// System.out.println("Ne postoji grad sa ovim nazivom");
					return -1;
				} else {
					idG = rs.getInt(1);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement ps = conn.prepareStatement("delete from Opstina where IdG=?");) {
			ps.setInt(1, idG);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res;
	}

	@Override
	public boolean deleteDistrict(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("delete from Opstina where IdO=?");) {
			ps.setInt(1, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res > 0 ? true : false;
	}

	@Override
	public int deleteDistricts(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		if (arg0.length == 0) {
			return 0;
		}
		String query = "delete from Opstina where Naziv=?";
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
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res;
	}

	@Override
	public List<Integer> getAllDistricts() {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> opstine = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Opstina where IdG=?");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				opstine.add(rs.getInt(1));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return opstine;
	}

	@Override
	public List<Integer> getAllDistrictsFromCity(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> opstine = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Opstina where IdG=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					opstine.add(rs.getInt(1));
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return opstine;
	}

	@Override
	public int insertDistrict(String arg0, int arg1, int arg2, int arg3) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Grad where IdG=?");) {
			stmt.setInt(1, arg1);
			try (ResultSet rs = stmt.executeQuery()) {
				if (!rs.next()) {
					// System.out.println("Ne postoji grad sa ovim indeksom");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt1 = conn.prepareStatement("select * from Opstina where Naziv=? and IdG=?");) {
			stmt1.setString(1, arg0);
			stmt1.setInt(2, arg1);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (rs1.next()) {
					// System.out.println("Vec postoji opstina sa ovim nazivom u datom gradu");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn
				.prepareStatement("insert into Opstina (Naziv, IdG, KordX, KordY) values(?, ?, ?, ?)")) {
			ps.setString(1, arg0);
			ps.setInt(2, arg1);
			ps.setInt(3, arg2);
			ps.setInt(4, arg3);
			ps.executeUpdate();
			// System.out.println("Ubacena je opstina: " + arg0 + ", " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt2 = conn.prepareStatement("select * from Opstina where Naziv=? and IdG=?")) {
			stmt2.setString(1, arg0);
			stmt2.setInt(2, arg1);
			try (ResultSet rs2 = stmt2.executeQuery()) {
				if (rs2.next()) {
					return rs2.getInt(1);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_DistrictOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return -1;
	}

}
