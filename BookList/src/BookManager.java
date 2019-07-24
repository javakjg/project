import java.io.*;
import java.util.Arrays;
import java.util.Scanner;

public class BookManager {

	final String FileName 	= "Book.data";
	Book Test2 = new Book();
	BookLink Head = null;
	BookLink Temp;
	byte[] rData = new byte[]{32,25,1,40,0,32,25,7,41};//파일 헤더 비교하기위한 배열
	
	public void load()
	{
		try {
			////파일 읽기//////
			FileInputStream IFileStream = new FileInputStream(FileName);
			////헤더를 배열로 읽어오기////
			byte[] RMagicNumber = new byte[9];
			IFileStream.read(RMagicNumber);
			System.out.println(" ** 불러올 수 있는 헤더 : 32, 25, 1, 40, 0, 32, 25, 7, 41");
			System.out.print(" ** 해당 파일의 헤더 :    ");
			for(int is = 0; is<9; is++)
			{
			System.out.print(RMagicNumber[is]+", ");
			}
			System.out.println();
			if(Arrays.equals(rData, RMagicNumber)) //배열 비교java.util.arrays
			{ 
				System.out.println(" ** 헤더가 동일합니다. 파일을 불러 옵니다.");
				ObjectInputStream FileLoad = new ObjectInputStream(IFileStream); 


				Test2 = (Book)FileLoad.readObject();
				Book 		objBook ;
				BookLink 	temp;
				int iCnt;
				for(iCnt = 0; Test2.res() > iCnt; ++iCnt)
				{
					objBook = (Book)FileLoad.readObject();
					temp = new BookLink(objBook);
					Head = BookLink.Insert(Head, temp);
				}
				FileLoad.close();
				
			} 
			else
			{
				System.out.println(" ** 파일을 읽을 수 없습니다![Diffrent Header]");
			
				IFileStream.close();
			}
			
			

		}
		catch(FileNotFoundException e)
		{
			System.out.println(" ** 불러올 Book.data 파일이 없습니다.");
			System.out.println(" ** 프로그램을 실행 합니다.");
		}
		catch(IOException e)
		{
			System.out.println(" ** 입출력 에러!");
		}
		catch(ClassNotFoundException e)
		{
			System.out.println(" ** 클래스를 찾을 수 없습니다.");
		}
	}
	public void Menu()
	{
		System.out.println("=====================================");
		System.out.println("======== 도서 관리  프로그램 ========");
		System.out.println("=-----------------------------------=");
		System.out.println("= 1. 책 추가                        =");
		System.out.println("= 2. 책 삭제                        =");
		System.out.println("= 3. 책 리스트                      =");
		System.out.println("= 9. 종료                           =");
		System.out.println("=====================================");
	}
	public void Run()
	{	load();

		Scanner Command = new Scanner(System.in);
		int 	iCmd;
		Scanner info = new Scanner(System.in); 
		





		while(true)
		{
			Menu();
			System.out.print("명령을 입력하세요 : ");
			iCmd = Command.nextInt();
			if(1 == iCmd)
			{
				
				
				System.out.print("책 이름 : ");
				String Name = info.nextLine();
				while(Name.trim().length() == 0)
				{
					System.out.println("책 이름을 제대로 입력 해 주세요.");
					Name = info.nextLine();
				}
				System.out.print("책 저자 : ");
				String Ath = info.nextLine();
				System.out.print("책 가격 : ");
				int price = info.nextInt();
				info.nextLine();
				System.out.print("출판사 : ");
				String pub = info.nextLine();

				Temp = new BookLink(Name,Ath,price,pub);
				Head = BookLink.Insert(Head, Temp);
				System.out.println("입력되었습니다.");
				Test2.plusMinus(1);;
			}
			else if(2 == iCmd)
			{
				System.out.print("삭제할 책 이름을 적어주세요 : ");
				String Name = info.next();
				info.nextLine();
				Head = BookLink.Del(Head, Name);
				Test2.plusMinus(2);;
			}
			else if(3 == iCmd)
			{
				if(Head == null)
					System.out.println("리스트가 없습니다.");
				else

					Head.print();
			}
			else if(9 == iCmd)
			{
				try
				{
					//파일 생성/////////////////////////
					FileOutputStream OFileStream = new FileOutputStream(FileName); 
					//////// File Header 생성 //////////////////////// 
					byte[] WMagicNumber = {32,25,1,40,0,32,25,7,41}; 
					OFileStream.write(WMagicNumber); 
					//					OFileStream.write(3); 
					//////// File Data 생성 ////////////////////////// 
					ObjectOutputStream FileSave = new ObjectOutputStream(OFileStream);
					FileSave.writeObject(Test2);
					BookLink Test1 = Head;
					while(null != Test1)
					{
						FileSave.writeObject(Test1.rBook);
						Test1 = Test1.rNext;
					}
					FileSave.close(); 
					OFileStream.close();
					System.out.println("Book.data 파일이 생성되었습니다.");
					System.out.println("도서 관리 프로그램을 종료합니다");
					break;
				}
				catch(IOException e)
				{
					System.out.println("입출력 오류");
				}
			}
		}
	}

}
