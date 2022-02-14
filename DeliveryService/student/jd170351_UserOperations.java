package student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.UserOperations;

public class jd170351_UserOperations implements UserOperations {

	public jd170351_UserOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public int declareAdmin(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Korisnik where KorIme=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					try (PreparedStatement stmt1 = conn.prepareStatement("select * from Administrator where IdK=?");) {
						stmt1.setInt(1, rs.getInt(1));
						try (ResultSet rs1 = stmt1.executeQuery()) {
							if (rs1.next()) {
								// System.out.println("Postoji vec administrator sa ovim korisnickim imenom");
								return 1;
							} else {
								try (PreparedStatement ps = conn
										.prepareStatement("insert into Administrator (IdK) values (?)")) {
									ps.setInt(1, rs.getInt(1));
									int res = ps.executeUpdate();
									if (res > 0) {
										return 0;
									} else {
										return 3;
									}
									// System.out.println("Ubacen je korisnik: " + arg0);
								} catch (SQLException ex) {
									Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
								}
								return 0;
							}
						} catch (SQLException ex) {
							Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
						}
					} catch (SQLException ex) {
						Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
					}
				} else {
					// System.out.println("Ne postoji korisnik sa ovim korisnickim imenom");
					return 2;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return 2;
	}

	@Override
	public int deleteUsers(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		if (arg0.length == 0) {
			return 0;
		}
		String query = "delete from Korisnik where KorIme=?";
		for (int i = 0; i < arg0.length - 1; i++) {
			query += " or KorIme=?";
		}
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement(query);) {
			for (int i = 0; i < arg0.length; i++) {
				ps.setString(i + 1, arg0[i]);
			}
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return res;
	}

	@Override
	public List<String> getAllUsers() {
		Connection conn = DB.getInstance().getConnection();
		List<String> korisnici = new ArrayList<String>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Korisnik");
				ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				korisnici.add(rs.getString(4));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return korisnici;
	}

	@Override
	public Integer getSentPackages(String... arg0) {
		Connection conn = DB.getInstance().getConnection();
		if (arg0.length == 0) {
			return null;
		}
		String query = "select * from Korisnik where KorIme=?";
		for (int i = 0; i < arg0.length - 1; i++) {
			query += " or KorIme=?";
		}
		int res = 0;
		try (PreparedStatement stmt = conn.prepareStatement(query);) {
			for (int i = 0; i < arg0.length; i++) {
				stmt.setString(i + 1, arg0[i]);
			}
			try (ResultSet rs = stmt.executeQuery()) {
				if (!rs.next()) {
					return null;
				} else {
					res += rs.getInt(6);
				}
				while (rs.next()) {
					res += rs.getInt(6);
				}
				return res;
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return null;
	}

	@Override
	public boolean insertUser(String arg0, String arg1, String arg2, String arg3) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Korisnik where KorIme=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					// System.out.println("Vec postoji grad sa ovim nazivom ili postanskim brojem");
					return false;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement(
				"insert into Korisnik (KorIme, Ime, Prezime, Sifra, BrPoslPaketa) values(?, ?, ?, ?, 0)")) {
			ps.setString(1, arg0);
			ps.setString(2, arg1);
			ps.setString(3, arg2);
			ps.setString(4, arg3);
			int res = ps.executeUpdate();
			if (res > 0) {
				return true;
			} else {
				return false;
			}
			// System.out.println("Ubacen je korisnik: " + arg0);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_UserOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		return false;
	}

}
