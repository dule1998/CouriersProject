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

import rs.etf.sab.operations.CourierOperations;

public class jd170351_CourierOperations implements CourierOperations {

	public jd170351_CourierOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean deleteCourier(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("delete from Kurir where IdK=(select IdK from Korisnik where KorIme=?)");) {
			ps.setString(1, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_CityOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res > 0 ? true : false;
	}

	@Override
	public List<String> getAllCouriers() {
		Connection conn = DB.getInstance().getConnection();
		List<String> kuriri = new ArrayList<String>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Kurir k join Korisnik ko on k.IdK=ko.IdK");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				kuriri.add(rs.getString(9));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return kuriri;
	}

	@Override
	public BigDecimal getAverageCourierProfit(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		BigDecimal profiti = new BigDecimal(0);
		BigDecimal brojKurira = new BigDecimal(0);
		try (PreparedStatement stmt = conn.prepareStatement("select * from Kurir where BrojIsporPaketa>?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					profiti = profiti.add(rs.getBigDecimal(4));
					brojKurira = brojKurira.add(new BigDecimal(1));
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return brojKurira.compareTo(new BigDecimal(0)) != 0 ? profiti.divide(brojKurira) : new BigDecimal(0);
	}

	@Override
	public List<String> getCouriersWithStatus(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		List<String> kuriri = new ArrayList<String>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Kurir where Status=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					kuriri.add(rs.getString(6));
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_VehicleOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return kuriri;
	}

	@Override
	public boolean insertCourier(String arg0, String arg1) {
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

		try (PreparedStatement ps = conn.prepareStatement("insert into Kurir (IdK, IdV, BrojIsporPaketa, Profit, Status) values(?, ?, 0, 0, 0)")) {
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
