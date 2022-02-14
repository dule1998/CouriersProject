package student;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import rs.etf.sab.operations.PackageOperations;

public class jd170351_PackageOperations implements PackageOperations {

	public static double[] osnovnaCena = {10, 25, 75};
	public static double[] tezinskiFaktor = {0, 1, 2};
	public static double[] cenaPoKG = {0, 100, 300};
	public static double[] tipGor = {15, 32, 36};
	
	public jd170351_PackageOperations() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public boolean acceptAnOffer(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		int idK = -1;
		int idP = -1;
		int tezina = 0;
		int tipPaketa = 0;
		int idO1 = -1;
		int idO2 = -1;
		int kordX1 = 0;
		int kordY1 = 0;
		int kordX2 = 0;
		int kordY2 = 0;
		BigDecimal procena = new BigDecimal(0);
		try (PreparedStatement stmt = conn.prepareStatement("select * from Ponuda where IdPon=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (!rs.next()) {
					// System.out.println("Ne postoji ponuda sa datim korisnickim imenom");
					return false;
				} else {
					idK = rs.getInt(2);
					idP = rs.getInt(3);
					procena = rs.getBigDecimal(1);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt3 = conn.prepareStatement("select * from Prevoz where IdP=?");) {
			stmt3.setInt(1, idP);
			try (ResultSet rs3 = stmt3.executeQuery()) {
				if (!rs3.next()) {
					// System.out.println("Ne postoji ponuda sa datim korisnickim imenom");
					return false;
				} else {
					idO1 = rs3.getInt(2);
					idO2 = rs3.getInt(3);
					tipPaketa = rs3.getInt(5);
					tezina = rs3.getInt(6);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt1 = conn.prepareStatement("select * from Opstina where IdO=?");) {
			stmt1.setInt(1, idO1);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (!rs1.next()) {
					// System.out.println("Ne postoji opstina sa datim korisnickim imenom");
					return false;
				} else {
					kordX1 = rs1.getInt(3);
					kordY1 = rs1.getInt(4);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt2 = conn.prepareStatement("select * from Opstina where IdO=?");) {
			stmt2.setInt(1, idO2);
			try (ResultSet rs2 = stmt2.executeQuery()) {
				if (!rs2.next()) {
					// System.out.println("Ne postoji opstina sa datim korisnickim imenom");
					return false;
				} else {
					kordX2 = rs2.getInt(3);
					kordY2 = rs2.getInt(4);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement ps = conn.prepareStatement("insert into Paket (IdP, IdK, Cena, Vreme) values(?, ?, ?, CONVERT(DATETIME, GETDATE()))")) {
			ps.setInt(1, idP);
			ps.setInt(2, idK);
			double euklid =  Math.sqrt(Math.pow(kordX1 - kordX2, 2) + Math.pow(kordY1 - kordY2, 2));
			BigDecimal procenat = (procena.divide(new BigDecimal(100))).add(new BigDecimal(1));
			BigDecimal cena = (new BigDecimal((osnovnaCena[tipPaketa] + (tezinskiFaktor[tipPaketa] * tezina) * cenaPoKG[tipPaketa]) * euklid)).multiply(procenat);
			ps.setBigDecimal(3, cena);
			ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement ps1 = conn.prepareStatement("update Prevoz set Status=1 where IdP=?");) {
			ps1.setInt(1, idP);
			ps1.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement ps2 = conn.prepareStatement("update Ponuda set Procena=-1 where IdPon=?");) {
			ps2.setInt(1, arg0);
			ps2.executeUpdate();
			return true;
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return false;
	}

	@Override
	public boolean changeType(int arg0, int arg1) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		if (arg1 < 0 || arg1 > 2) {
			return false;
		}
		try (PreparedStatement ps = conn.prepareStatement("update Prevoz set TipPaketa=? where IdP=?");) {
			ps.setInt(1, arg1);
			ps.setInt(2, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return res > 0 ? true : false;
	}

	@Override
	public boolean changeWeight(int arg0, BigDecimal arg1) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("update Prevoz set Tezina=? where IdP=?");) {
			ps.setBigDecimal(1, arg1);
			ps.setInt(2, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return res > 0 ? true : false;
	}

	@Override
	public boolean deletePackage(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		int res = 0;
		try (PreparedStatement ps = conn.prepareStatement("delete from Prevoz where IdP=?");) {
			ps.setInt(1, arg0);
			res = ps.executeUpdate();
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return res > 0 ? true : false;
	}

	@Override
	public int driveNextPackage(String arg0) {
		Connection conn = DB.getInstance().getConnection();
		boolean bool = false;
		List<Integer> paketi = new ArrayList<Integer>();
		List<Integer> statusi = new ArrayList<Integer>();
		int idK = -1;
		int tipGoriva = -1;
		BigDecimal potrosnja = new BigDecimal(0);
		try (PreparedStatement stmt = conn.prepareStatement("select * from Prevoz p join Paket pa on p.IdP=pa.IdP join Kurir k on k.IdK=pa.IdK join Korisnik ko on k.IdK=ko.IdK where ko.KorIme=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					idK = rs.getInt(11);
					paketi.add(rs.getInt(1));
					statusi.add(rs.getInt(7));
					if (rs.getInt(7) == 1) {
						bool = true;
					}
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt = conn.prepareStatement("select * from Kurir k join Vozilo v on k.IdV=v.IdV  where IdK=?");) {
			stmt.setInt(1, idK);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					tipGoriva = rs.getInt(8);
					potrosnja = rs.getBigDecimal(9);
				} else {
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		if (!bool) {
			int brojac = 0;
			for (int i = 0; i < paketi.size(); i++) {
				if (statusi.get(i) == 2) {
					brojac++;
				}
			}
			
			if (brojac == 1) {
				BigDecimal cenaPuta = new BigDecimal(0);
				BigDecimal cenaPaketa = new BigDecimal(0);
				try (PreparedStatement stmt = conn.prepareStatement("select * from Voznja v join Prevoz p on v.IdP=p.IdP join Paket pa on p.IdP=pa.IdP join Kurir k on pa.IdK=k.IdK join Korisnik ko on k.IdK=ko.IdK join Opstina o1 on o1.IdO=p.IdO1 join Opstina o2 on o2.IdO=p.IdO2 where ko.KorIme=?");) {
					stmt.setString(1, arg0);
					try (ResultSet rs = stmt.executeQuery()) {
						boolean poslePrvogPuta = false;
						int kordX = -1;
						int kordY = -1;
						double rastojanje = 0;
						while (rs.next()) {
							double rastojanje1 = 0;
							if (poslePrvogPuta) {
								rastojanje1 = Math.sqrt(Math.pow(rs.getInt(26) - kordX, 2) + Math.pow(rs.getInt(27) - kordY, 2));
							}
							double rastojanje2 = Math.sqrt(Math.pow(rs.getInt(26) - rs.getInt(31), 2) + Math.pow(rs.getInt(27) - rs.getInt(32), 2));
							rastojanje += rastojanje1 + rastojanje2;
							kordX = rs.getInt(31);
							kordY = rs.getInt(32);
							poslePrvogPuta = true;
						}
						cenaPuta = (new BigDecimal(rastojanje * tipGor[tipGoriva])).multiply(potrosnja);
					} catch (SQLException ex) {
						Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
					}
				} catch (SQLException ex) {
					Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
				}
				
				try (PreparedStatement stmt = conn.prepareStatement("select * from Voznja v join Paket p on v.IdP=p.IdP  where IdK=?");) {
					stmt.setInt(1, idK);
					try (ResultSet rs = stmt.executeQuery()) {
						while (rs.next()) {
							cenaPaketa = cenaPaketa.add(rs.getBigDecimal(2));
						}
					} catch (SQLException ex) {
						Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
					}
				} catch (SQLException ex) {
					Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
				}
				
				try (PreparedStatement ps = conn.prepareStatement("update Kurir set Profit=Profit+? where IdK=?");) {
					ps.setBigDecimal(1, cenaPaketa.subtract(cenaPuta));
					ps.setInt(2, idK);
					ps.executeUpdate();
				} catch (SQLException ex) {
					Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
				}
				
				for (Integer paket : paketi) {
					try (PreparedStatement ps = conn.prepareStatement("delete from Voznja where IdP=?");) {
						ps.setInt(1, paket);
						ps.executeUpdate();
					} catch (SQLException ex) {
						Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
					}
				}
			}
			
			for (int i = 0; i < paketi.size(); i++) {
				if (statusi.get(i) != 2) {
					paketi.remove(i);
					statusi.remove(i--);
				}
			}
			
			try (PreparedStatement ps = conn.prepareStatement("update Prevoz set Status=? where IdP=?");) {
				ps.setInt(1, 3);
				ps.setInt(2, paketi.get(0));
				ps.executeUpdate();
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			
			try (PreparedStatement ps = conn.prepareStatement("update Kurir set BrojIsporPaketa=BrojIsporPaketa+1 where IdK=?");) {
				ps.setInt(1, idK);
				ps.executeUpdate();
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			
			return paketi.get(0);
		} else {
			for (Integer paket : paketi) {
				try (PreparedStatement ps = conn.prepareStatement("insert into Voznja (IdP) values(?)", PreparedStatement.RETURN_GENERATED_KEYS)) {
					ps.setInt(1, paket);
					ps.executeUpdate();
				} catch (SQLException ex) {
					Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
				}
			}
		
			try (PreparedStatement ps = conn.prepareStatement("update Prevoz set Status=? where IdP=?");) {
				ps.setInt(1, 3);
				ps.setInt(2, paketi.get(0));
				ps.executeUpdate();
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			
			try (PreparedStatement ps = conn.prepareStatement("update Kurir set BrojIsporPaketa=BrojIsporPaketa+1 where IdK=?");) {
				ps.setInt(1, idK);
				ps.executeUpdate();
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			
			if (paketi.size() > 1) {
				for (int i = 1; i < paketi.size(); i++) {
					if (statusi.get(i) != 1) {
						statusi.remove(i);
						paketi.remove(i--);
					}
				}
				for (int i = 1; i < paketi.size(); i++) {
					try (PreparedStatement ps = conn.prepareStatement("update Prevoz set Status=? where IdP=?");) {
						ps.setInt(1, 2);
						ps.setInt(2, paketi.get(i));
						ps.executeUpdate();
					} catch (SQLException ex) {
						Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
					}
				}
			}
			
			return paketi.get(0);
		}
	}

	@Override
	public Date getAcceptanceTime(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Paket where IdP=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return rs.getDate(2);
				} else {
					// System.out.println("Ne postoji paket sa datim indeksom");
					return null;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return null;
	}

	@Override
	public List<Integer> getAllOffers() {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> ponude = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Ponuda"); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				ponude.add(rs.getInt(4));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return ponude;
	}

	@Override
	public List<Pair<Integer, BigDecimal>> getAllOffersForPackage(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		List<Pair<Integer, BigDecimal>> ponude = new ArrayList<Pair<Integer, BigDecimal>>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Ponuda"); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				ponude.add(new PairClass(rs.getInt(4), rs.getBigDecimal(1)));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return ponude;
	}

	@Override
	public List<Integer> getAllPackages() {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> paketi = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Prevoz"); ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				paketi.add(rs.getInt(1));
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return paketi;
	}

	@Override
	public List<Integer> getAllPackagesWithSpecificType(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		List<Integer> paketi = new ArrayList<Integer>();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Prevoz where TipPaketa=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					paketi.add(rs.getInt(1));
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		return paketi;
	}

	@Override
	public Integer getDeliveryStatus(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Prevoz where IdP=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(7);
				} else {
					// System.out.println("Ne postoji paket sa datim indeksom");
					return null;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return null;
	}

	@Override
	public List<Integer> getDrive(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BigDecimal getPriceOfDelivery(int arg0) {
		Connection conn = DB.getInstance().getConnection();
		try (PreparedStatement stmt = conn.prepareStatement("select * from Paket where IdP=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					return rs.getBigDecimal(1);
				} else {
					// System.out.println("Ne postoji paket sa datim indeksom");
					return null;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		return null;
	}

	@Override
	public int insertPackage(int arg0, int arg1, String arg2, int arg3, BigDecimal arg4) {
		Connection conn = DB.getInstance().getConnection();
		int idK = -1;
		try (PreparedStatement stmt = conn.prepareStatement("select * from Opstina where IdO=?");) {
			stmt.setInt(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (!rs.next()) {
					// System.out.println("Ne postoji data opstina");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt1 = conn.prepareStatement("select * from Opstina where IdO=?");) {
			stmt1.setInt(1, arg1);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (!rs1.next()) {
					// System.out.println("Ne postoji data opstina");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt2 = conn.prepareStatement("select * from Korisnik where KorIme=?");) {
			stmt2.setString(1, arg2);
			try (ResultSet rs2 = stmt2.executeQuery()) {
				if (!rs2.next()) {
					// System.out.println("Ne postoji korisnik sa datim korisnickim imenom");
					return -1;
				} else {
					idK = rs2.getInt(1);
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement("insert into Prevoz (IdK, IdO1, IdO2, TipPaketa, Tezina, Status) values(?, ?, ?, ?, ?, 0)", PreparedStatement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, idK);
			ps.setInt(2, arg0);
			ps.setInt(3, arg1);
			ps.setInt(4, arg3);
			ps.setBigDecimal(5, arg4);
			ps.executeUpdate();
			try (ResultSet rs=ps.getGeneratedKeys();) {
	            if(rs.next()) {
	            	return rs.getInt(1);
	            }
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			// System.out.println("Ubacen je paket: " + string + ", " + string1);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		return -1;
	}

	@Override
	public int insertTransportOffer(String arg0, int arg1, BigDecimal arg2) {
		Connection conn = DB.getInstance().getConnection();
		int idK = -1;
		int idP = -1;
		try (PreparedStatement stmt = conn.prepareStatement("select * from Kurir k join Korisnik ko on k.IdK=ko.IdK where ko.KorIme=?");) {
			stmt.setString(1, arg0);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					idK = rs.getInt(1);
				} else {
					// System.out.println("Ne postoji kurir sa datim korisnickim imenom");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}
		
		try (PreparedStatement stmt1 = conn.prepareStatement("select * from Prevoz where IdP=?");) {
			stmt1.setInt(1, arg1);
			try (ResultSet rs1 = stmt1.executeQuery()) {
				if (rs1.next()) {
					idP = rs1.getInt(1);
				} else {
					// System.out.println("Ne postoji paket sa datim indeksom");
					return -1;
				}
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		try (PreparedStatement ps = conn.prepareStatement("insert into Ponuda (IdP, IdK, Procena) values(?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS)) {
			ps.setInt(1, idP);
			ps.setInt(2, idK);
			ps.setBigDecimal(3, arg2);
			ps.executeUpdate();
			try (ResultSet rs=ps.getGeneratedKeys();) {
	            if(rs.next()) {
	            	return rs.getInt(1);
	            }
			} catch (SQLException ex) {
				Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
			}
			// System.out.println("Ubacen je paket: " + string + ", " + string1);
		} catch (SQLException ex) {
			Logger.getLogger(jd170351_PackageOperations.class.getName()).log(Level.SEVERE, null, ex);
		}

		return -1;
	}
	
	public class PairClass implements Pair<Integer, BigDecimal> {

		private Integer a;
		private BigDecimal b;
		
		public PairClass(Integer a, BigDecimal b) {
			this.a = a;
			this.b = b;
		}
		
		@Override
		public Integer getFirstParam() {
			return a;
		}

		@Override
		public BigDecimal getSecondParam() {
			return b;
		}
		
	}

}
