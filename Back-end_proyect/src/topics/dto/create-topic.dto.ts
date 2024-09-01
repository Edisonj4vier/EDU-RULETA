import {
  IsString,
  MinLength,
  IsOptional,
  IsUrl,
  IsUUID,
} from 'class-validator';

export class CreateTopicDto {
  @IsString()
  @MinLength(3)
  nombre: string;

  @IsString()
  @MinLength(10)
  descripcion: string;

  @IsOptional()
  @IsUrl()
  url_video?: string;

  @IsOptional()
  @IsUrl()
  url_imagen?: string;

  @IsUUID()
  course_id: string;
}
