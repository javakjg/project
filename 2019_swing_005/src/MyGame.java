import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import javax.swing.*;

import org.w3c.dom.events.MouseEvent; 

class MySokoban extends JFrame implements KeyListener, ActionListener
{ 
	final int IXSize   = 60; // image x
	final int IYSize   = 60; // image y
	final int BXSize   = 14; // block x
	final int BYSize   = 10; // block y
	final int DXSize   = IXSize*BXSize; //display x size : pixel
	final int DYSize   = IYSize*BYSize; //display y size : pixel
	final int LThick   = 3;
	final int MXSize   = LThick + LThick; // Margin x size : pixel(Left+Right)
	final int MYUSize  = 23 + LThick; // Margin y Up size : pixel(Title+Top)
	final int MYSize   = MYUSize+ LThick; // Margin y size : pixel(Title+Top+Bottom)
	final String RTitle = "Reset";
	final String Title = "겜만들기 005";
	
	
	Image IWall   	= Toolkit.getDefaultToolkit().getImage("Wall.png"); 
	Image IManF   	= Toolkit.getDefaultToolkit().getImage("ManF.png");
	Image IManB   	= Toolkit.getDefaultToolkit().getImage("ManB.png");
	Image IManL   	= Toolkit.getDefaultToolkit().getImage("ManL.png");
	Image IManR   	= Toolkit.getDefaultToolkit().getImage("ManR.png");
	Image IMan   	= IManF;
	Image IDot   	= Toolkit.getDefaultToolkit().getImage("Dot.png");
	Image IBox   	= Toolkit.getDefaultToolkit().getImage("Box.png");
	Image IRoad		= Toolkit.getDefaultToolkit().getImage("Road.png");
	int iStage		= 0;
	int iXMan		= 0;
	int iYMan 		= 0;
	boolean bEndGame = true;
	int iScore;
	JLabel TitleLabel;
	JButton ButReset;
	JButton ButUp;
	JButton ButDown;
	JButton ButLeft;
	JButton ButRight;
	
	char [][] Map = new char[BYSize][BXSize];
	String [][] Stage		= {
								{
									"##############",//11111111111111111111111
									"#            #",
									"#     B      #",
									"#     .      #",
									"#            #",
									"#            #",
									"#     B .    #",
									"#            #",
									"#      @     #",
									"##############"//111111111111111111111111
								},
								{
									"##############",//22222222222222222222222
									"#   @ B. B.  #",
									"#            #",
									"#            #",
									"#            #",
									"#            #",
									"#            #",
									"#            #",
									"#            #",
									"##############"//222222222222222222222222
								}
		
							};


	public MySokoban() 
	{ 
		this.setTitle(Title); 
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		Container c = this.getContentPane();
		c.setLayout(null);
		
		
		ButUp = new JButton("UP");
		ButUp.setFont(new Font("Arial", Font.BOLD, 10));
		ButUp.setLocation(910, 400);
		ButUp.setSize(60,60);
		ButUp.addActionListener(this);
		c.add(ButUp);
		
		ButDown = new JButton("DOWN");
		ButDown.setFont(new Font("Arial", Font.BOLD, 10));
		ButDown.setLocation(910, 500);
		ButDown.setSize(60,60);
		ButDown.addActionListener(this);
		c.add(ButDown);
		
		ButLeft = new JButton("LEFT");
		ButLeft.setFont(new Font("Arial", Font.BOLD, 10));
		ButLeft.setLocation(845, 450);
		ButLeft.setSize(60,60);
		ButLeft.addActionListener(this);
		c.add(ButLeft);
		
		ButRight = new JButton("RIGHT");
		ButRight.setFont(new Font("Arial", Font.BOLD, 9));
		ButRight.setLocation(975, 450);
		ButRight.setSize(60,60);
		ButRight.addActionListener(this);
		c.add(ButRight);
		
		ButReset = new JButton("Reset");
		ButReset.setFont(new Font("Arial", Font.BOLD, 13));
		ButReset.setLocation(880, 150);
		ButReset.setSize(80,65);
		ButReset.addActionListener(this);
		c.add(ButReset);
		
		
		
		TitleLabel = new JLabel();
		TitleLabel.setFont(new Font("굴림", Font.BOLD, 25));
		TitleLabel.setLocation(880,30);
		TitleLabel.setSize(200, 50);
		c.add(TitleLabel);
		
		
		c.addKeyListener(this);
		c.setFocusable(true);
		c.requestFocus();
		
		this.setSize(DXSize+MXSize+200, DYSize+MYUSize+LThick); 
		this.setVisible(true); 
		this.setResizable(false);
		
		LoadMap();	
		
			
			

	}
	void LoadMap()
	{
		for(int iCnt = 0; iCnt<Stage[iStage].length; ++iCnt)
		{
			Map[iCnt] = Stage[iStage][iCnt].toCharArray();
		}
		IMan = IManF;
		iScore = 0;
		
	}
	public void paint(Graphics g)
	{ 	Image aImage;
		bEndGame = true;
		super.paintComponents(g);
		Container c = this.getContentPane();
		c.requestFocus();
		while(true)
		{
			for(int iY=0; iY<BYSize; ++iY) 
			{ 
				for(int iX=0; iX<BXSize; ++iX) 
				{
					switch(Map[iY][iX])
					{
					case '#' :
						aImage = this.IWall;
						break;
					case '@' :
						aImage = this.IMan;
						iXMan = iX;
						iYMan = iY;
						break;
					case 'B' :
						char [] MapLine = Stage[iStage][iY].toCharArray();
						if('.' != MapLine[iX])
						{
							bEndGame = false;
						}
						aImage = this.IBox;
						break;
					case '.' :
						aImage = this.IDot;
						break;
					default :
						aImage = this.IRoad;
						break;
					}
					g.drawImage(aImage, iX*IXSize+LThick, iY*IYSize+MYUSize, this);	
				}//System.out.println(Map[iY]);//디버깅코드
			}
			this.setTitle(Title+"[Score : "+iScore+"]");
			TitleLabel.setText("Score : "+iScore);
			
			if(true == bEndGame)
			{
				++iStage;
				if(Stage.length <= iStage) // 게임종료
				{
					JOptionPane.showMessageDialog(null, "종료");
					System.exit(0);
				}
				JOptionPane.showMessageDialog(null, "다음판");//블로킹 메소드
				System.out.println("완료");
				LoadMap();
				continue;
			}
			break;
		}//while
	}
	public void ManMove(int iX, int iY)
	{
		if('#' != Map[iY][iX]) // @가 이동할 위치가 벽이 아닐 때
		{
			if('B' == Map[iY][iX]) // @가 이동할 위치에 박스가 있으면
			{
				//Map[2*iY-iYMan][2*iX-iXMan] : 박스가 이동할 위치
				if('#' == Map[2*iY-iYMan][2*iX-iXMan]) // 박스가 이동할 위치에 벽이면 아무도 이동불가
				{
					iY = iYMan;
					iX = iXMan;
					--iScore;
				}
				else if('B' == Map[2*iY-iYMan][2*iX-iXMan]) // 박스가 이동할 위치가 박스면 : 아무도 이동하면 안된다.
				{
					iY = iYMan;
					iX = iXMan;
					--iScore;
				}
				else// 박스가 이동할 위치가 벽과 박스가 아니면
				{
					Map[2*iY-iYMan][2*iX-iXMan] = 'B';
				}
				
			}
			char [] MapLine = Stage[iStage][iYMan].toCharArray();
			if('.' == MapLine[iXMan])
			{
				Map[iYMan][iXMan] = '.'; // @의 기존 위치를 '.'로 만듦
			}
			else
			{
				Map[iYMan][iXMan] = ' '; // @의 기존 위치를 길로 만듦
			}	
			Map[iY][iX] = '@';		// @를 새로운 위치로 이동 시킴
			++iScore;
		}
	}
	

	@Override
	public void keyPressed(KeyEvent e) 
	{
		int iX = iXMan;// iX는 뉴좌표, iXMan는 올드좌표
		int iY = iYMan;// iY는 뉴좌표, iYMan는 올드좌표
		Map[iYMan][iXMan] = '@';
		switch(e.getKeyCode())
		{
		case KeyEvent.VK_HOME:
			LoadMap();
			repaint();
			return;
		case KeyEvent.VK_UP:
//			System.out.println("VKUP");
			IMan = IManB;
			--iY;
				break;				
		case KeyEvent.VK_DOWN:
			IMan = IManF;
			++iY;
			break;
		case KeyEvent.VK_LEFT:
			IMan = IManL;
			--iX;
			break;
		case KeyEvent.VK_RIGHT:
			IMan = IManR;
			++iX;
			break;
		default:
			return;
		}
		ManMove(iX, iY);
		repaint();//paint 호출
	}

	@Override
	public void keyReleased(KeyEvent e) {}
	@Override
	public void keyTyped(KeyEvent e) {}
	@Override
	public void actionPerformed(ActionEvent e) {
		JButton Temp = (JButton)e.getSource();
		
		if(Temp.equals(ButReset))
			
		{
			LoadMap();
			repaint();
			return;
		}
		
		int iX = iXMan;
		int iY = iYMan;
		if(Temp.equals(ButUp))
		{
			IMan = IManB; 
			   --iY;
			
		}
		else if(Temp.equals(ButDown))
		{
				
			IMan = IManF; 
			   ++iY;
			
		}
		else if(Temp.equals(ButLeft))
		{
			IMan = IManL; 
			   --iX;	
			
		}
		else if(Temp.equals(ButRight))
		{
			IMan = IManR; 
			   ++iX; 	
			
		}
		ManMove(iX, iY); 
		repaint();
		
	} 
}

public class MyGame 
{ 
	public static void main(String[] args) 
	{ 
		MySokoban aMySokoban = new MySokoban(); 
	} 
}
