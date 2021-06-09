package android;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;

public class ChatServer {
	private HashMap<String,DataOutputStream> clients;
	private ServerSocket serverSocket=null;
	
	public ChatServer() {
		//클라이언트를 저장하기 위한 해시맵
		clients=new HashMap<>();
		//클라이언트 동기화
		Collections.synchronizedMap(clients);
	}
	public static void main(String[] args) {
		new ChatServer().start();
	}
	void start() {
		int port=5001;
		Socket socket=null;
		try {
			serverSocket=new ServerSocket(port); //서비스 제공 소켓
			System.out.println("접속 대기중");
			while(true) {
				socket=serverSocket.accept(); //접속 허가
				InetAddress ip=socket.getInetAddress();
				System.out.println(ip+" connected");
				//채팅 서비스를 위한 스레드 시작
				new MultiThread(socket).start();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	class MultiThread extends Thread {
		Socket socket=null;
		String mac=null;
		String msg=null;
		DataInputStream input;
		DataOutputStream output;
		
		public MultiThread(Socket socket) {
			this.socket=socket;
			try {
				//데이터를 주고 받을 스트림 생성 
				input=new DataInputStream(socket.getInputStream());
				output=new DataOutputStream(socket.getOutputStream());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {
			try {
				//mac address 출력
				mac=input.readUTF();
				System.out.println("mac address:"+mac);
				//클라이언트에 mac address 전달
				clients.put(mac, output);
				sendMsg(mac+" 접속");
				//채팅 메시지 수신
				while(input != null) {
					try {
						String temp=input.readUTF();
						sendMsg(temp);
						System.out.println(temp);
					} catch (Exception e) {
						sendMsg("No message");
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//클라이언트에 메시지를 보내는 함수
		void sendMsg(String msg) {
			//클라이언트의 key 집합
			Iterator<String> it=clients.keySet().iterator();
			while(it.hasNext()) {
				try {
					OutputStream os=clients.get(it.next());
					DataOutputStream output=new DataOutputStream(os);
					output.writeUTF(msg);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}
}
