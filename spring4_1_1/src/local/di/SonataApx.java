package local.di;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/*
 * ApplicationContext     >    BeanFactory
 * context.jar                  bean.jar 빈관리
 * 
 *   singleton
 *   propotype
 *   request
 *   session
 * 
 */
public class SonataApx {

	public static void main(String[] args) {
		Sonata herCar = new Sonata(); //이렇게 하지말자. 라이프사이클 직접 관리해야함
		ApplicationContext context =
				//new ClassPathXmlApplicationContext("sonataBean.xml"); 
				//위처럼 쓰면 Loading XML bean definitions from class path resource [sonataBean.xml] 에러남
				//경로를 못찾음. 아래와 같이 경로는 써줘야함
				new ClassPathXmlApplicationContext("local\\di\\sonataBean.xml");
		Sonata myCar = null; //이게 맞아 null!
		myCar = (Sonata)context.getBean("myCar");
		System.out.println(myCar.toString());
		Sonata yourCar = null;
		/////////////////////여기 아래부터 터짐. session과 request는 확인할 수 없다.
		yourCar = (Sonata)context.getBean("yourCar");
		System.out.println(yourCar.toString());
		System.out.println("yourCar의 현재 속도는 "+yourCar.getSpeed()+" 입니다.");
		Sonata meCar = null;
		meCar = (Sonata)context.getBean("meCar");
		System.out.println(meCar.toString());
		System.out.println("meCar의 현재 속도는 "+meCar.getSpeed()+" 입니다.");
		Sonata himaCar = null;
		himaCar = (Sonata)context.getBean("himaCar");
		System.out.println(himaCar.toString());
		System.out.println("himaCar의 현재 속도는 "+himaCar.getSpeed()+" 입니다.");
	}

}
