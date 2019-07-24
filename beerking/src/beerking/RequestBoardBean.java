package beerking;

public class RequestBoardBean {
	private int requestboardnum;
	private int usernum;
	private String requestboardtitle;
    private String requestboardcomment;  
    private String requestboarddate;   
    private String requestboardtime;     
    private int filenum;
    private int status;

	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getRequestboardnum() {
		return requestboardnum;
	}
	public void setRequestboardnum(int requestboardnum) {
		this.requestboardnum = requestboardnum;
	}
	public int getUsernum() {
		return usernum;
	}
	public void setUsernum(int usernum) {
		this.usernum = usernum;
	}
	public String getRequestboardtitle() {
		return requestboardtitle;
	}
	public void setRequestboardtitle(String requestboardtitle) {
		this.requestboardtitle = requestboardtitle;
	}
	public String getRequestboardcomment() {
		return requestboardcomment;
	}
	public void setRequestboardcomment(String requestboardcomment) {
		this.requestboardcomment = requestboardcomment;
	}
	public String getRequestboarddate() {
		return requestboarddate;
	}
	public void setRequestboarddate(String requestboarddate) {
		this.requestboarddate = requestboarddate;
	}
	public String getRequestboardtime() {
		return requestboardtime;
	}
	public void setRequestboardtime(String requestboardtime) {
		this.requestboardtime = requestboardtime;
	}
	public int getFilenum() {
		return filenum;
	}
	public void setFilenum(int filenum) {
		this.filenum = filenum;
	}           

    
}
