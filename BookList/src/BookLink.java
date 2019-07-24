class BookLink
{
	Book 		rBook;
	BookLink 	rNext;
	
	static public BookLink Del(BookLink Head, String BookName)
	{
		BookLink Current 	= Head;
		BookLink Prev 		= Head;
		
		while(null != Current) // ���Ḯ��Ʈ ������ �˻�
		{
			//������ ��ġ ����
			if(BookName.equals(Current.rBook.GetBookName()))
			{
				break;
			}
			Prev 	= Current;
			Current = Current.rNext;
		}
		
		if(null == Current)//Ŀ��Ʈ�� ���̸� ����
		{
			System.out.println("["+BookName+"]�� �̸��� ���� å�� �����ϴ�.");
		}
		else if(Head == Current)// ���� �� ����
		{
			Head = Head.rNext;
			System.out.println("�����Ǿ����ϴ�.");
		}
		else
		{
			Prev.rNext = Current.rNext;//����
			System.out.println("�����Ǿ����ϴ�.");
		}
		return Head;
	}
	
	static public BookLink Insert(BookLink Head, BookLink New)
	{
		if(null != Head)
		{
			BookLink Current 	= Head;
			BookLink Prev 		= Head;
			
			//������ ��ġ �˻�
			while(null != Current) // ���Ḯ��Ʈ ������ �˻�
			{
				if(0  > New	.rBook
							.GetBookName()
							.compareTo(Current.rBook.GetBookName()))//������ ��ġ ����
				{
					break;
				}
				Prev 	= Current;
				Current = Current.rNext;
			}

			if(Current == Head)// �� �� ����
			{
				New.rNext 	= Head;
				Head 		= New;
			}
			else // �߰� ����
			{
				Prev.rNext 	= New;
				New.rNext 	= Current;
			}
		}
		else
		{
			Head = New;
		}

		return Head;
	}
	public BookLink(String rName,String rAutho,int iPrice,String rPub)
	{
		rBook = new Book(rName, rAutho, iPrice, rPub);
		rNext = null;
	}
	public BookLink(Book NewObj)
	{
		rBook = NewObj;
		rNext = null;
	}
	public void print()
	{
		BookLink Current = this;
		System.out.println("===========================");
		System.out.println("======== Book List ========");
		System.out.println("---------------------------");
		while(null != Current)
		{
			Current.rBook.print();
			Current = Current.rNext;
		}
		System.out.println("===========================");
	}	
}

