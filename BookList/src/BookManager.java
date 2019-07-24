import java.io.*;
import java.util.Arrays;
import java.util.Scanner;

public class BookManager {

	final String FileName 	= "Book.data";
	Book Test2 = new Book();
	BookLink Head = null;
	BookLink Temp;
	byte[] rData = new byte[]{32,25,1,40,0,32,25,7,41};//���� ��� ���ϱ����� �迭
	
	public void load()
	{
		try {
			////���� �б�//////
			FileInputStream IFileStream = new FileInputStream(FileName);
			////����� �迭�� �о����////
			byte[] RMagicNumber = new byte[9];
			IFileStream.read(RMagicNumber);
			System.out.println(" ** �ҷ��� �� �ִ� ��� : 32, 25, 1, 40, 0, 32, 25, 7, 41");
			System.out.print(" ** �ش� ������ ��� :    ");
			for(int is = 0; is<9; is++)
			{
			System.out.print(RMagicNumber[is]+", ");
			}
			System.out.println();
			if(Arrays.equals(rData, RMagicNumber)) //�迭 ��java.util.arrays
			{ 
				System.out.println(" ** ����� �����մϴ�. ������ �ҷ� �ɴϴ�.");
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
				System.out.println(" ** ������ ���� �� �����ϴ�![Diffrent Header]");
			
				IFileStream.close();
			}
			
			

		}
		catch(FileNotFoundException e)
		{
			System.out.println(" ** �ҷ��� Book.data ������ �����ϴ�.");
			System.out.println(" ** ���α׷��� ���� �մϴ�.");
		}
		catch(IOException e)
		{
			System.out.println(" ** ����� ����!");
		}
		catch(ClassNotFoundException e)
		{
			System.out.println(" ** Ŭ������ ã�� �� �����ϴ�.");
		}
	}
	public void Menu()
	{
		System.out.println("=====================================");
		System.out.println("======== ���� ����  ���α׷� ========");
		System.out.println("=-----------------------------------=");
		System.out.println("= 1. å �߰�                        =");
		System.out.println("= 2. å ����                        =");
		System.out.println("= 3. å ����Ʈ                      =");
		System.out.println("= 9. ����                           =");
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
			System.out.print("����� �Է��ϼ��� : ");
			iCmd = Command.nextInt();
			if(1 == iCmd)
			{
				
				
				System.out.print("å �̸� : ");
				String Name = info.nextLine();
				while(Name.trim().length() == 0)
				{
					System.out.println("å �̸��� ����� �Է� �� �ּ���.");
					Name = info.nextLine();
				}
				System.out.print("å ���� : ");
				String Ath = info.nextLine();
				System.out.print("å ���� : ");
				int price = info.nextInt();
				info.nextLine();
				System.out.print("���ǻ� : ");
				String pub = info.nextLine();

				Temp = new BookLink(Name,Ath,price,pub);
				Head = BookLink.Insert(Head, Temp);
				System.out.println("�ԷµǾ����ϴ�.");
				Test2.plusMinus(1);;
			}
			else if(2 == iCmd)
			{
				System.out.print("������ å �̸��� �����ּ��� : ");
				String Name = info.next();
				info.nextLine();
				Head = BookLink.Del(Head, Name);
				Test2.plusMinus(2);;
			}
			else if(3 == iCmd)
			{
				if(Head == null)
					System.out.println("����Ʈ�� �����ϴ�.");
				else

					Head.print();
			}
			else if(9 == iCmd)
			{
				try
				{
					//���� ����/////////////////////////
					FileOutputStream OFileStream = new FileOutputStream(FileName); 
					//////// File Header ���� //////////////////////// 
					byte[] WMagicNumber = {32,25,1,40,0,32,25,7,41}; 
					OFileStream.write(WMagicNumber); 
					//					OFileStream.write(3); 
					//////// File Data ���� ////////////////////////// 
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
					System.out.println("Book.data ������ �����Ǿ����ϴ�.");
					System.out.println("���� ���� ���α׷��� �����մϴ�");
					break;
				}
				catch(IOException e)
				{
					System.out.println("����� ����");
				}
			}
		}
	}

}
