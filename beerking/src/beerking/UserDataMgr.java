package beerking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDataMgr {
	private DBConnectionMgr pool;

	public UserDataMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//user insert
	public boolean insertUser(UserDataBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert userdata(usergrant,email,pwd,nickname,name,address,tel) values(?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getPwd());
			pstmt.setString(4, bean.getNickname());
			pstmt.setString(5, bean.getName());
			pstmt.setString(6, bean.getAddress());
			pstmt.setString(7, bean.getTel());   
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//user trand insert
		public void insertUserTrand() {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert usertrand() values()";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}

	//user login
	public boolean loginUser(String email,String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select email from userdata where email=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	//user update
	public boolean updateUser(UserDataBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update userdata set pwd = ?,nickname = ?,address = ?,tel = ? where usernum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getNickname());
			pstmt.setString(3, bean.getAddress());
			pstmt.setString(4, bean.getTel());   
			pstmt.setInt(5, bean.getUsernum());   
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	//user select
	public UserDataBean selectUser(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		UserDataBean bean = new UserDataBean();
		try {
			con = pool.getConnection();
			sql = "select * from userdata where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUsernum(rs.getInt("usernum"));
				bean.setUsergrant(rs.getInt("usergrant"));
				bean.setEmail(rs.getString("email"));
				bean.setPwd(rs.getString("pwd"));
				bean.setNickname(rs.getString("nickname"));
				bean.setName(rs.getString("name"));
				bean.setAddress(rs.getString("address"));
				bean.setTel(rs.getString("tel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	//user nickname select
	public String getNickname(int usernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		String nickname = "";
		try {
			con = pool.getConnection();
			sql = "select nickname from userdata where usernum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				nickname = rs.getString("nickname");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return nickname;
	}

	//user grant select
	public int getGrant(int usernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int usergrant = 1;
		try {
			con = pool.getConnection();
			sql = "select usergrant from userdata where usernum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				usergrant = rs.getInt("usergrant");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return usergrant;
	}

	//email search
	public String emailSearch(String name, String tel) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		String getEmail = "null";
		try {
			con = pool.getConnection();
			sql = "select email from userdata where name=? and tel=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, tel);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				getEmail = rs.getString("email");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return getEmail;
	}

	//pwd search
	public String pwdSearch(String email, String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		String getPwd = "null";
		try {
			con = pool.getConnection();
			sql = "select pwd from userdata where email=? and name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				getPwd = rs.getString("pwd");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return getPwd;
	}
	
	//check email
	public boolean emailCheck(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select * from userdata where email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
}
