      parameter (ngrid=25)  
      integer n1,n2,dum(ngrid,ngrid)
       xmin= -5.0 #Replace with actual value
       xmax= 5.0 #Replace with actual value
       ymin= -5.0 #Replace with actual value
       ymax= 5.0 #Replace with actual value
       delx=(xmax-xmin) / (ngrid-1)
       dely=(ymax-ymin) / (ngrid-1)

      do i=1,ngrid 
      do j=1,ngrid 
      dum(i,j)=0
      enddo
      enddo

      offset=0 

c      open(16, file='2d.dat', status='old')
      open(16, file='2dproj.xvg', status='old') #Replace with actual file name

      do i=1,20000 #Replace with actual number of frames
      read(16,*)x1,y1
      n1=int((x1-xmin)/delx)
      n2=int((y1-ymin)/dely)
      dum(n1,n2)=dum(n1,n2)+1
c      print *, n1,n2
      enddo
      
      do i =1,ngrid 
      do j =1,ngrid 
      x=xmin+(i-1)*delx
      y=ymin+(j-1)*dely
      if (dum(i,j).ne.0) then
      print *,x, y, -0.6*log(dum(i,j)*1.0)
      else
      print *, x,y, 0.0 
      endif 
      enddo
      print *
      enddo
      

      end

