package beerking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class BeerMgr {
	
	private DBConnectionMgr pool;

	public BeerMgr(){
		pool = DBConnectionMgr.getInstance();
	}
	
	//beer select
	public Vector<BeerBean> getAllBeer(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from beer";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BeerBean bean = new BeerBean();
				bean.setBeernum(rs.getInt("beernum"));
				bean.setBeerEname(rs.getString("beerename"));
				bean.setBeerKname(rs.getString("beerkname"));
				bean.setTypebig(rs.getString("typebig"));
				bean.setTypesmall(rs.getString("typesmall"));
				bean.setAlchol(rs.getDouble("alchol"));
				bean.setCompany(rs.getString("company"));
				bean.setCountry(rs.getString("country"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//beer select 4
	public Vector<BeerBean> getBeerLimit(String typesmall, int next){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from beer where typesmall = ? limit 0,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, typesmall);
			pstmt.setInt(2, next);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BeerBean bean = new BeerBean();
				bean.setBeernum(rs.getInt("beernum"));
				bean.setBeerEname(rs.getString("beerename"));
				bean.setBeerKname(rs.getString("beerkname"));
				bean.setTypebig(rs.getString("typebig"));
				bean.setTypesmall(rs.getString("typesmall"));
				bean.setAlchol(rs.getDouble("alchol"));
				bean.setCompany(rs.getString("company"));
				bean.setCountry(rs.getString("country"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//beer select Rank
		public Vector<BeerBean> getBeerRank(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<BeerBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				sql = "select * from beer b join beergrade g on b.beernum = g.beernum group by b.beernum order by AVG(beerscore) desc limit 0,3;";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					BeerBean bean = new BeerBean();
					bean.setBeernum(rs.getInt("beernum"));
					bean.setBeerEname(rs.getString("beerename"));
					bean.setBeerKname(rs.getString("beerkname"));
					bean.setTypebig(rs.getString("typebig"));
					bean.setTypesmall(rs.getString("typesmall"));
					bean.setAlchol(rs.getDouble("alchol"));
					bean.setCompany(rs.getString("company"));
					bean.setCountry(rs.getString("country"));
					bean.setFilename(rs.getString("filename"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	//beer select Rank AVG
	public String[] getRankAVG(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String AVG[] = new String [3];
		int i = 0;
		String pattern = "#.##";
		DecimalFormat dformat = new DecimalFormat(pattern);
		try {
			con = pool.getConnection();
			sql = "select AVG(beerscore) from beer b join beergrade g on b.beernum = g.beernum group by b.beernum order by AVG(beerscore) desc limit 0,3;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AVG[i] = dformat.format(rs.getDouble("AVG(beerscore)"));
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return AVG;
	}
	//beer select New
	public int[] getBeerNew(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int newBeer[] = new int[10];
		int i = 0;
		try {
			con = pool.getConnection();
			sql = "select beernum from beer order by beernum desc limit 0,10;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				newBeer[i] = rs.getInt("beernum");
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return newBeer;
	}
	//get typesmall beer
	public Vector<BeerBean> getBeerTypeSmall(String typesmall){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from beer where typesmall = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, typesmall);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BeerBean bean = new BeerBean();
				bean.setBeernum(rs.getInt("beernum"));
				bean.setBeerEname(rs.getString("beerename"));
				bean.setBeerKname(rs.getString("beerkname"));
				bean.setTypebig(rs.getString("typebig"));
				bean.setTypesmall(rs.getString("typesmall"));
				bean.setAlchol(rs.getDouble("alchol"));
				bean.setCompany(rs.getString("company"));
				bean.setCountry(rs.getString("country"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//get type small text
	public String getBeerText(String typesmall){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String info = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select info from typesmallinfo where typesmall = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, typesmall);
			rs = pstmt.executeQuery();	
			while(rs.next())
				info = rs.getString("info");			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return info;
	}
	
	//select Grade beer
		public boolean getGradeBeer(int usernum, int beernum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "select beergradenum from beergrade where usernum = ? and beernum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, usernum);
				pstmt.setInt(2, beernum);
				rs = pstmt.executeQuery();
				if(rs.next())
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}
		
	//get score beer
			public int getScoreBeer(int usernum, int beernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int score = 0;
				try {
					con = pool.getConnection();
					sql = "select beerscore from beergrade where usernum = ? and beernum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, usernum);
					pstmt.setInt(2, beernum);
					rs = pstmt.executeQuery();
					if(rs.next())
						score = rs.getInt("beerscore");
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return score;
			}
	//add Score beer
			public void addScoreBeer(int beerscore, int usernum, int beernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "insert beergrade(beerscore,usernum,beernum) values(?,?,?)";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, beerscore);
					pstmt.setInt(2, usernum);
					pstmt.setInt(3, beernum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
	//update Score beer
			public void updateScoreBeer(int beerscore, int usernum, int beernum) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				try {
					con = pool.getConnection();
					sql = "update beergrade set beerscore = ? where usernum = ? and beernum = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, beerscore);
					pstmt.setInt(2, usernum);
					pstmt.setInt(3, beernum);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return;
			}
	
	//select favorite beer
	public boolean getFavoriteBeer(int usernum, int beernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select favnum from favorite where usernum = ? and beernum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			pstmt.setInt(2, beernum);
			rs = pstmt.executeQuery();
			if(rs.next())
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//add favorite beer
	public void addFavoriteBeer(int usernum, int beernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert favorite(usernum,beernum) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			pstmt.setInt(2, beernum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//delete favorite beer
	public void deleteFavoriteBeer(int usernum, int beernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from favorite where usernum = ? and beernum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			pstmt.setInt(2, beernum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Beer Search
	public Vector<BeerBean> beerRead(String beerName){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from beer where beerEname like ? or beerKname like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,"%"+beerName+"%");
			pstmt.setString(2, "%"+beerName+"%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BeerBean bean = new BeerBean();
				bean.setBeernum(rs.getInt(1));
				bean.setBeerEname(rs.getString(2));
				bean.setBeerKname(rs.getString(3));
				bean.setTypebig(rs.getString(4));
				bean.setTypesmall(rs.getString(5));
				bean.setAlchol(rs.getDouble(6));
				bean.setCompany(rs.getString(7));
				bean.setCountry(rs.getString(8));
				bean.setFilename(rs.getString(9));
				vlist.addElement(bean);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}
