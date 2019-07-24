package beerking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import beerking.DBConnectionMgr;

public class RequestBoardMgr {

	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/beerking/beerking/WebContent/beerking/uesrimg/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;
	
	public RequestBoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//request board list
	public Vector<RequestBoardBean> getRequestBoardList(int start, int end){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<RequestBoardBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from requestBoard order by requestBoardNum desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				RequestBoardBean bean = new RequestBoardBean();
				bean.setRequestboardnum(rs.getInt("requestboardnum"));
				bean.setUsernum(rs.getInt("usernum"));
				bean.setRequestboardtitle(rs.getString("requestboardtitle"));
				bean.setRequestboardcomment(rs.getString("requestboardcomment"));
				bean.setRequestboarddate(rs.getString("requestboarddate"));
				bean.setRequestboardtime(rs.getString("requestboardtime"));
				bean.setFilenum(rs.getInt("filenum"));
				bean.setStatus(rs.getInt("status"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//request board read
	public RequestBoardBean readRequestBoar(int requestBoradNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		RequestBoardBean bean = new RequestBoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from requestboard where requestboardnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestBoradNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setRequestboardnum(rs.getInt("requestboardnum"));
				bean.setUsernum(rs.getInt("usernum"));
				bean.setRequestboardtitle(rs.getString("requestboardtitle"));
				bean.setRequestboardcomment(rs.getString("requestboardcomment"));
				bean.setRequestboarddate(rs.getString("requestboarddate"));
				bean.setRequestboardtime(rs.getString("requestboardtime"));
				bean.setFilenum(rs.getInt("filenum"));
				bean.setStatus(rs.getInt("status"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	//request board count
	public int getRequestBoardCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from requestboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//request board reply insert
	public void insertRequestReply(String requestReplyComment, int requestBoardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert freereply(requestreplycomment, requestreplydate, usernum, requestboardnum) values(?,now(),1,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, requestReplyComment);
			pstmt.setInt(2, requestBoardNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//request board reply delete
	public void deleteRequestReply(int requestreplynum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from freereply where requestreplynum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestreplynum); 
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//request board reply count
	public int getRequestReplyCount(int requestBoardNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from freereply where requestboardnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestBoardNum);
			rs = pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//request board Reply List
	public Vector<FreeReplyBean> getRequestReplyList(int requestBoardNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FreeReplyBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from freereply where requestboardnum=? order by requestreplydate desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestBoardNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FreeReplyBean bean = new FreeReplyBean();
				bean.setRequestreplynum(rs.getInt("requestreplynum"));
				bean.setUsernum(rs.getInt("usernum"));
				bean.setRequestreplycomment(rs.getString("requestreplycomment"));
				bean.setRequestreplydate(rs.getString("requestreplydate"));
				bean.setRequestboardnum(rs.getInt("requestboardnum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//Insert filetable
	public void uploadFile(String filename, int size)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int s = size/1000;
		try {
			con = pool.getConnection();
			sql = "insert filetable(filename, filesize) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, filename);
			pstmt.setInt(2, s);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//insert Writer
	public void insertWriter(String requesboardtitle,String requesboardcomment,int usernum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert requestboard(usernum,requestboardtitle, requestboardcomment,requestboarddate,requestboardtime,filenum,status) values(?,?,?,now(),now(),1,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, usernum);
			pstmt.setString(2, requesboardtitle);
			pstmt.setString(3, requesboardcomment);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	//get Wrtier
	public RequestBoardBean getWriter(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		RequestBoardBean rbean = new RequestBoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from requestboard where requestboardnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rbean.setFilenum(rs.getInt("filenum"));
				rbean.setRequestboardcomment(rs.getString("requestboardcomment"));
				rbean.setRequestboarddate(rs.getString("requestboarddate"));
				rbean.setRequestboardnum(rs.getInt("requestboardnum"));
				rbean.setRequestboardtime(rs.getString("requestboardtime"));
				rbean.setRequestboardtitle(rs.getString("requestboardtitle"));
				rbean.setStatus(rs.getInt("status"));
				rbean.setUsernum(rs.getInt("usernum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return rbean;
	}
	//writer update
	public void updateWriter(String requestboardtitle,String requestboardcomment,int usernum,int requestboardnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update requestboard set requestboardtitle = ?, requestboardcomment = ?, usernum = ?, requestboarddate=now(), requestboardtime=now() where requestboardnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, requestboardtitle);
			pstmt.setString(2, requestboardcomment);
			pstmt.setInt(3, usernum);
			pstmt.setInt(4, requestboardnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	//writer delete
	public void WriterDelete(int requestboardnum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update requestboard set status=1 where requestboardnum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, requestboardnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//writer delete reset
		public void WriterDelete2(int requestboardnum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update requestboard set status=0 where requestboardnum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, requestboardnum);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
	
	//Get UserDate2
		public UserDataBean getUser2(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			UserDataBean bean = new UserDataBean();
			try {
				con = pool.getConnection();
				sql = "select * from userdata where email = ?";
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
}
