import { IsNumber, IsOptional, IsString, IsUUID, Min } from 'class-validator';

export class CreateStudentCourseDto {
  @IsString()
  @IsUUID()
  @IsOptional()
  student_id: string;

  @IsString()
  @IsUUID()
  course_id: string;

  @IsNumber()
  @Min(0)
  @IsOptional()
  puntuacion: number;
}
