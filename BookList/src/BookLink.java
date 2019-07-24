class BookLink
{
	Book 		rBook;
	BookLink 	rNext;
	
	static public BookLink Del(BookLink Head, String BookName)
	{
		BookLink Current 	= Head;
		BookLink Prev 		= Head;
		
		while(null != Current) // 연결리스트 끝까지 검색
		{
			//삭제할 위치 결정
			if(BookName.equals(Current.rBook.GetBookName()))
			{
				break;
			}
			Prev 	= Current;
			Current = Current.rNext;
		}
		
		if(null == Current)//커런트가 널이면 없다
		{
			System.out.println("["+BookName+"]의 이름을 가진 책이 없습니다.");
		}
		else if(Head == Current)// 제일 앞 삭제
		{
			Head = Head.rNext;
			System.out.println("삭제되었습니다.");
		}
		else
		{
			Prev.rNext = Current.rNext;//삭제
			System.out.println("삭제되었습니다.");
		}
		return Head;
	}
	
	static public BookLink Insert(BookLink Head, BookLink New)
	{
		if(null != Head)
		{
			BookLink Current 	= Head;
			BookLink Prev 		= Head;
			
			//삽입할 위치 검색
			while(null != Current) // 연결리스트 끝까지 검색
			{
				if(0  > New	.rBook
							.GetBookName()
							.compareTo(Current.rBook.GetBookName()))//삽입할 위치 결정
				{
					break;
				}
				Prev 	= Current;
				Current = Current.rNext;
			}

			if(Current == Head)// 맨 앞 삽입
			{
				New.rNext 	= Head;
				Head 		= New;
			}
			else // 중간 삽입
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

