import java.io.*; 

class Book implements Serializable 
{ 
	private String  rName; 
	private String  rAutho; 
	private int  iPrice; 
	private String  rPub; 
	int RecordNum = 0;
	public int res()
	{
		return RecordNum;
	}
	public void plusMinus(int a)
	{
		if(a == 1)
		{
			this.RecordNum++;
		}
		if(a == 2)
		{
			this.RecordNum--;
		}
	}

	Book()
	{
		return;
	}
	public String GetBookName() 
	{ 
		return rName; 
	} 
	public Book(String rName,String rAutho,int iPrice,String rPub) 
	{ 
		this.rName   = rName; 
		this.rAutho  = rAutho; 
		this.iPrice  = iPrice; 
		this.rPub   = rPub; 
	} 
	public String toString() 
	{ 
		return "["+rName+"]:"+rAutho+":"+iPrice+":"+rPub; 
	} 
	public void print() 
	{ 
		System.out.println(toString()); 
	}//print() 
}//class Book