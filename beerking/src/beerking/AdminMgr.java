package beerking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.eclipse.jdt.internal.compiler.codegen.VerificationTypeInfo;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AdminMgr {

	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/beerking/beerking/WebContent/beerking/beerimg/"; //파일업로드 경로
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;
	
	
	public AdminMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	public boolean insertBeer(HttpServletRequest req) {//관리자 DB정보 등록
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, UPLOAD, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			con = pool.getConnection();
			sql = "insert beer(beerEname, beerKname, typebig, typesmall, alchol, company, country, filename)values(?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("beerEname"));
			pstmt.setString(2, multi.getParameter("beerKname"));
			pstmt.setString(3, multi.getParameter("typebig"));
			pstmt.setString(4, multi.getParameter("typesmall"));
			pstmt.setDouble(5, Double.parseDouble(multi.getParameter("alchol")));
			pstmt.setString(6, multi.getParameter("company"));
			pstmt.setString(7, multi.getParameter("country"));
			if(multi.getFilesystemName("filename") == null)
				pstmt.setString(8, "ready.gif");
			else
				pstmt.setString(8, multi.getFilesystemName("filename"));
			if(pstmt.executeUpdate() == 1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	//get manyLikeBeer
	
	
	//list getMaxlikeBeer 이번달의 리뷰게시글 중 리뷰좋아요를 가장 많이 받은 리뷰게시물3개의 맥주 3개를 뽑아내기
	public Vector<BeerBean> getMaxlikeBeerNum()
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BeerBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select b.beernum, r.filename, r.beerEname, r.beerkname from reviewboard b join (select reviewnum, count(*) from reviewlike r1 group by reviewnum) q on q.reviewnum = b.reviewnum join beer r on b.beernum = r.beernum where substr(b.reviewdate,1,7) = substr(curdate(),1,7) limit 0,3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				BeerBean bean = new BeerBean();
				bean.setBeernum(rs.getInt(1));
				bean.setFilename(rs.getString(2));
				bean.setBeerEname(rs.getString(3));
				bean.setBeerKname(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	
	//list getMaxlikeReview  이번달 기준 좋아요를 많이 받은 리뷰게시글 3개 불러오기
	public Vector<ReviewBoardBean> getMaxlikeReview()
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBoardBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select b.reviewnum, b.filename, b.reviewtitle from(select reviewnum, count(*) from reviewlike r1 group by reviewnum) q join reviewboard b on b.reviewnum = q.reviewnum where substr(b.reviewdate,1,7) = substr(curdate(),1,7) and b.reviewstate = 0 limit 0,3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				ReviewBoardBean bean = new ReviewBoardBean(); 
				bean.setReviewnum(rs.getInt(1));
				bean.setFilename(rs.getString(2));
				bean.setReviewtitle(rs.getString(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//Insert MonthBeer 이번달 맥주 추가 (맥주넘버와 코멘트를 달아야함.)
	public void insertMonthBeer(int beernum, String Comment)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert monthbeer(beernum,Udate,adminComment) values(?,now(),?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, beernum);
			pstmt.setString(2, Comment);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	//Insert MonthBeer 이번달 맥주 초기화
		public void resetMonthBeer()
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert monthbeer(beernum,Udate,adminComment) values(?,now(),?)";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, 1);
				pstmt.setString(2, "초기값");
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return;
		}
	
	//reset MonthReview 이번달 리뷰 초기화
	public void resetMonthReview()
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert monthreview(reviewnum,Udate,state) values(?,now(),?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, 1);
			pstmt.setString(2, "초기값");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}	
	
	// get monthreview state
		public String getMreviewState()
		{
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String state ="";
			try {
				con = pool.getConnection();
				sql = "select state from monthreview order by mReviewNum desc";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {				
				state = rs.getString("state");				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return state;
		}
		
	//Insert MonthReview 이번달 리뷰 추가
	public void insertMonthReview(int reviewnum)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert monthreview(reviewnum,Udate) values(?,now())";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, reviewnum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return;
	}
	
	
	// monthBeer 메인 페이지 이번달 최고의 맥주
	public BeerBean getMbeer()
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BeerBean bean = new BeerBean();
		try {
			con = pool.getConnection();
			sql = "select b.beernum, b.beerEname, b.beerkname, b.typebig, b.typesmall, b.alchol, b.filename from monthbeer m join beer b on m.beernum = b.beernum order by mbeerNum desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			
			bean.setBeernum(rs.getInt(1));
			bean.setBeerEname(rs.getString(2));
			bean.setBeerKname(rs.getString(3));
			bean.setTypebig(rs.getString(4));
			bean.setTypesmall(rs.getString(5));
			bean.setAlchol(rs.getDouble(6));
			bean.setFilename(rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	//get monthBeer 이번달 맥주 등록날짜 뽑아내는 Mgr
	public MonthBeerBean getMdata(int beernum)
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MonthBeerBean bean = new MonthBeerBean();
		try {
			con = pool.getConnection();
			sql = "select beernum, substr(Udate,1,10), adminComment from monthbeer where beernum=? order by mbeernum desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, beernum);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setBeernum(rs.getInt(1));
				bean.setUdate(rs.getString(2));
				bean.setAdminComment(rs.getString(3));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// monthReview 메인 페이지 이번달 최고의 리뷰
	public ReviewBoardBean getMreview()
	{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReviewBoardBean bean = new ReviewBoardBean();
		try {
			con = pool.getConnection();
			sql = "select b.reviewnum, b.reviewtitle, b.reviewdate, b.reviewcomment, b.filename from reviewboard b join monthreview m on b.reviewnum = m.reviewnum order by m.mReviewNum desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				bean.setReviewnum(rs.getInt(1));
				bean.setReviewtitle(rs.getString(2));
				bean.setReviewdate(rs.getString(3));
				bean.setReviewcomment(rs.getString(4));
				bean.setFilename(rs.getString(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
}
