package student;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.CourierRequestOperation;

public class jd170351_CourierRequestOperation implements CourierRequestOperation {

	public jd170351_CourierRequestOperation() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean changeVehicleInCourierRequest(String arg0, String arg1) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement ps = conn.prepareStatement(
				"update Zahtev set IdV=? where IdK=(select IdK from Korisnik where KorIme=?)")) {
			ps.setString(1, arg1);
			ps.setString(2, arg0);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Promenjen je zahtev: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}
		return false;
	}

	@Override
	public boolean deleteCourierRequest(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("delete from Zahtev where IdK=(select IdK from Korisnik where KorIme=?)");) {
			ps.setString(1, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res > 0 ? true : false;
	}

	@Override
	public List<String> getAllCourierRequests() {
		Connection conn = DB.getInstance().getConnection();
		List<String> zahtevi = new ArrayList<String>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Zahtev z join Korisnik k on z.IdK=k.IdK");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				zahtevi.add(rs.getString(6));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}
		return zahtevi;
	}

	@Override
	public boolean grantRequest(String arg0) {
		Connection conn=DB.getInstance().getConnection();
        String query="{ call spOdobriZahtev (?,?) }"; 
        try (CallableStatement cs= conn.prepareCall(query)){
            cs.setString(1, arg0);
            cs.registerOutParameter(2, java.sql.Types.INTEGER);
            cs.execute();
            return cs.getInt(2) == 1 ? true : false;
        } catch (SQLException ex) {
            Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
	}

	@Override
	public boolean insertCourierRequest(String arg0, String arg1) {
		Connection conn = DB.getInstance().getConnection();
		int idK = -1;
		int idV = -1;
		try (PreparedStatement stmt = conn
				.prepareStatement("select * from Kurir k join Vozilo v on k.IdV = v.IdV where v.RegBr=?");) {
			stmt.setString(1, arg1);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					// System.out.println("Postoji kurir sa datim vozilom");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt1 = conn
				.prepareStatement("select * from Zahtev z join Korisnik k on z.IdK = k.IdK where k.KorIme=?");) {
			stmt1.setString(1, arg0);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (rs1.next()) {
					// System.out.println("Vec postoji zahtev");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt2 = conn.prepareStatement("select * from Vozilo where RegBr=?");) {
			stmt2.setString(1, arg1);
			try (ResultSet rs2 = stmt2.executeQuery()) {
				if (rs2.next()) {
					idV = rs2.getInt(1);
				} else {
					// System.out.println("Ne postoji vozilo");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement stmt3 = conn.prepareStatement("select * from Korisnik where KorIme=?");) {
			stmt3.setString(1, arg0);
			try (ResultSet rs3 = stmt3.executeQuery()) {
				if (rs3.next()) {
					idK = rs3.getInt(1);
				} else {
					// System.out.println("Ne postoji korisnik");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement("insert into Zahtev (IdK, IdV) values(?, ?)")) {
			ps.setInt(1, idK);
			ps.setInt(2, idV);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Ubacen je korisnik: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CourierRequestOperation.class.getName()).log(Level.SEVERE, null, ex);
		}

		return false;
	}

}
